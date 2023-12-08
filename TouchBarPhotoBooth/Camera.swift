/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view that provides a preview of the content the camera captures.
*/
import AVFoundation

@MainActor
class Camera: ObservableObject {
    internal let output = AVCapturePhotoOutput()
    internal let session = AVCaptureSession()
    
    private(set) var alert = false
    private(set) var states = States.unknown
    private(set) var isSetup = false
    private(set) var isAuthorized = false
    private(set) var isRunning = false
    
    enum States: @unchecked Sendable {
        case unknown
        case unauthorized
        case failed
        case running
        case stopped
    }
    
    lazy var preview: (String) -> CameraPreview = { incomingFilter in
        CameraPreview(session: self.session, filter: incomingFilter)
    }
    
    func start() async {
        guard await authorize() else {
            self.states = .unauthorized
            return
        }
        do {
            try setup()
            startSession()
        } catch {
            states = .failed
        }
    }
    
    internal func authorize() async -> Bool {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        isAuthorized = status == .authorized
        if status == .notDetermined {
            isAuthorized = await AVCaptureDevice.requestAccess(for: .video)
        }
        return isAuthorized
    }
    
    internal func setup() throws {
        guard !isSetup else { return }
        
        session.beginConfiguration()
        session.sessionPreset = .high
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        guard let input = try? AVCaptureDeviceInput(device: captureDevice) else { return }
        session.addInput(input)
        session.addOutput(output)
        session.commitConfiguration()
        isSetup = true
    }
    
    internal func startSession() {
        Task.detached(priority: .userInitiated) {
            guard await !self.isRunning else { return }
            self.session.startRunning()
            await MainActor.run {
                self.isRunning = self.session.isRunning
                self.states = .running
            }
        }
    }
}
