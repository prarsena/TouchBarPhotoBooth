// visit peterarsenault.industries
import SwiftUI

struct ContentView: View {
    @StateObject var camera = Camera()
    @State private var previewPhotoEffect = ""
    
    var body: some View {
        ZStack(){
            camera.preview(previewPhotoEffect)
                .padding()
                .frame(maxWidth: .infinity)
            TextField("", text: $previewPhotoEffect)
                .frame(width:0, height:0)
                .focusable()
                .touchBar(){
                    TouchBarView(camera: camera, previewPhotoEffect: $previewPhotoEffect, w:70)
                }
        }
        .frame(maxWidth: .infinity)
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
