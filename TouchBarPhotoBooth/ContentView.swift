// visit peterarsenault.industries
import SwiftUI

struct ContentView: View {
    @StateObject var camera = Camera()
    @State private var previewPhotoEffect = ""
    @State var placeholder = "unreal"
    
    var body: some View {
        
        ZStack(){
            camera.preview(previewPhotoEffect)
                .frame(maxWidth: .infinity)
            TextField("TouchBar Demo", text: $previewPhotoEffect)
                .frame(width:0, height: 0)
                .focusable()
                .touchBar(){
                    TouchBarView(camera: camera, previewPhotoEffect: $previewPhotoEffect, w:70)
                }
        }
        .frame(maxWidth:.infinity)
        .padding()
        .onAppear {
            Task {
                await camera.start()
            }
        }
        .onDisappear(
            perform: {
                NSApp.terminate(self)
            }
        )
    }
}

#Preview {
    ContentView()
}
