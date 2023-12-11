// visit peterarsenault.industries
import SwiftUI

struct TouchBarView: View {
    var camera: Camera
    @Binding var previewPhotoEffect: String
    @State var w: CGFloat?
    @State var h: CGFloat?
  
    var body: some View {
        ScrollView(.horizontal){
            HStack(){
                Button(action: {
                    camera.filter = previewPhotoEffect
                    camera.capturePhoto()
                }, label: {
                    Image(systemName: "camera")
                }).touchBarItemPrincipal(true)
                    .frame(width:w, height:h)
                        .controlSize(.large)
                
                Button(action: {
                    previewPhotoEffect = "CISepiaTone"
                    //camera.filter = previewPhotoEffect
                }, label: {
                    camera.preview("CISepiaTone")
                }).frame(width:w, height:h)
                    .controlSize(.large)
                
                Button(action: {
                    previewPhotoEffect = "CIColorInvert"
                }, label: {
                    camera.preview("CIColorInvert")
                }).frame(width:w, height:h)
                    .controlSize(.large)
                
                Button(action: {
                    previewPhotoEffect = "CIThermal"
                }, label: {
                    camera.preview("CIThermal")
                }).frame(width:w, height:h)
                    .controlSize(.large)
                
                Button(action: {
                    previewPhotoEffect = "CIDotScreen"
                }, label: {
                    camera.preview("CIDotScreen")
                }).frame(width:w, height:h)
                    .controlSize(.large)
                
                Button(action: {
                    previewPhotoEffect = "CIPixellate"
                }, label: {
                    camera.preview("CIPixellate")
                }).frame(width:w, height:h)
                    .controlSize(.large)
                
                Button(action: {
                    previewPhotoEffect = "CIPointillize"
                }, label: {
                    camera.preview("CIPointillize")
                }).frame(width:w, height:h)
                    .controlSize(.large)
                
                Button(action: {
                    previewPhotoEffect = "CIGaborGradients"
                }, label: {
                    camera.preview("CIGaborGradients")
                }).frame(width:w, height:h)
                    .controlSize(.large)
                
                Button(action: {
                    previewPhotoEffect = "CIComicEffect"
                }, label: {
                    camera.preview("CIComicEffect")
                }).frame(width:w, height:h)
                    .controlSize(.large)
                
                Button(action: {
                    previewPhotoEffect = "CIColorMonochrome"
                }, label: {
                    camera.preview("CIColorMonochrome")
                }).frame(width:w, height:h)
                    .controlSize(.large)
                
                Button(action: {
                    NSApp.terminate(self)
                }, label: {
                    Image(systemName: "xmark.circle")
                }).frame(width:w, height:h)
                        .controlSize(.large)
            }.frame(minHeight: 0, maxHeight: .greatestFiniteMagnitude)
            
        }
    }
}
