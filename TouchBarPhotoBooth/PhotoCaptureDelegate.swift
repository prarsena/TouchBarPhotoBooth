// visit peterarsenault.industries
import AVFoundation
import SwiftUI
import CoreImage

public class PhotoCaptureDelegate: NSObject, AVCapturePhotoCaptureDelegate {
    var filter: String?
    
    init(filter: String?) {
        self.filter = filter
        super.init()
    }
    
    func convertImageDataToFilteredImageData(data: Data, filter: String?) -> Data? {
        let image = NSImage(data: data)
        guard let oldciImage = CIImage(data: image!.tiffRepresentation!) else {
            fatalError("Could not convert NSImage to CIImage.")
        }
        
        var f = CIFilter(name: "CIMedianFilter")
        
        if (filter != ""){
            f = CIFilter(name: filter!)
        }
        
        /*
        //Apply ciimage filter extension
        //var ciImage = oldciImage.hexagonalPixellateEffect()
        //f.setValue(ciImage, forKey: kCIInputImageKey)
         */
        
        f!.setValue(oldciImage, forKey: kCIInputImageKey)
        
        guard let outputCIImage = f?.outputImage else {
            fatalError("Could not get output CIImage from filter.")
        }
        
        // Convert CIImage to NSImage
        //let filteredImage = NSCIImageRep(ciImage: outputCIImage)
        let rep = NSCIImageRep(ciImage: outputCIImage)
        let nsImage = NSImage(size: rep.size)
        nsImage.addRepresentation(rep)
        
        // Convert NSImage to Data in TIFF format
        guard let tiffData = nsImage.tiffRepresentation else {
            fatalError("Could not get TIFF representation of NSImage.")
        }
        
        // Create an NSBitmapImageRep from the TIFF data
        guard let bitmapImageRep = NSBitmapImageRep(data: tiffData) else {
            fatalError("Could not create NSBitmapImageRep from TIFF data.")
        }
        
        // Specify the desired image format (e.g., JPEG)
        let format = NSBitmapImageRep.FileType.jpeg
        let properties: [NSBitmapImageRep.PropertyKey: Any] = [:]
        
        // Convert NSBitmapImageRep to Data in the specified format
        guard let imageData = bitmapImageRep.representation(using: format, properties: properties) else {
            fatalError("Could not convert NSBitmapImageRep to Data.")
        }
        
        return imageData
    }
    
    public func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        print("Finished processing photo.")
        guard let imageData = photo.fileDataRepresentation() else { return }
        NSSound(named: "Frog")?.play()
        //guard let filteredImageData = convertImageDataToFilteredImageData(data: imageData, filter: filter) else { return }
        
        let picturesDir = FileManager.default.urls(for: .picturesDirectory, in: .userDomainMask).first!
        let imagesPath = picturesDir.appendingPathComponent("TouchBarPhotoBooth")
        
        do
        {
            try FileManager.default.createDirectory(atPath: imagesPath.path, withIntermediateDirectories: true, attributes: nil)
            let timestamp = NSDate().timeIntervalSince1970
            let date = NSDate(timeIntervalSince1970:timestamp)
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd-HHmmss"
            let humanReadableTimeStamp = formatter.string(from: date as Date)
            
            let fileURL = imagesPath.appendingPathComponent("Selfie\(humanReadableTimeStamp).jpg")
            try? imageData.write(to: fileURL)
        }
        catch let error as NSError
        {
            NSLog("Unable to create directory \(error.debugDescription)")
        }
    }
}
