/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view that provides a preview of the content the camera captures.
*/
import SwiftUI
import AVFoundation

struct CameraPreview: NSViewRepresentable {
    private var session: AVCaptureSession
    private var filter: String
    
    init(session: AVCaptureSession, filter: String) {
        self.session = session
        self.filter = filter
    }
    
    func makeNSView(context: Context) -> CaptureVideoPreview {
        CaptureVideoPreview(session: session, filter: filter)
    }
    
    func updateNSView(_ nsView: CaptureVideoPreview, context: Context) {
        nsView.updateFilter(session: session, filter: filter)
    }
    
    class CaptureVideoPreview: NSView {
        var previewLayer = AVCaptureVideoPreviewLayer()
        init(session: AVCaptureSession, filter: String) {
            super.init(frame: .zero)
            
            previewLayer = AVCaptureVideoPreviewLayer(session: session)
            previewLayer.videoGravity = .resizeAspectFill
            previewLayer.connection?.automaticallyAdjustsVideoMirroring = false
            previewLayer.backgroundColor = .black
            previewLayer.compositingFilter = CIFilter(name:filter)
            layer = previewLayer
            wantsLayer = true
        }
        
        func updateFilter(session: AVCaptureSession,filter: String){
            print("Filter name: \(filter)")
            previewLayer.videoGravity = .resizeAspectFill
            previewLayer.connection?.automaticallyAdjustsVideoMirroring = false
            previewLayer.backgroundColor = .black
            previewLayer.compositingFilter = CIFilter(name:filter)
            layer = previewLayer
            wantsLayer = true
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}
