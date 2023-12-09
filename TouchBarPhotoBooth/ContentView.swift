// visit peterarsenault.industries
import SwiftUI

struct ContentView: View {
    @StateObject var camera = Camera()
    @State private var previewPhotoEffect = ""
    
    var body: some View {
        VStack(){
            HStack(){
                camera.preview(previewPhotoEffect)
                    .frame(maxWidth: .infinity)
            }
            //TouchBarView(camera: camera, previewPhotoEffect: $previewPhotoEffect, w:70)
        }
        .padding()
        .focusable()
        .touchBar(){
            TouchBarView(camera: camera, previewPhotoEffect: $previewPhotoEffect, w:70)
        }
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
