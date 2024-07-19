import SwiftUI

@main
struct MyApp: App {
    
    @State private var showLoadScreen = true
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if showLoadScreen {
                    LoadScreenView()
                        .transition(.opacity)
                } else {
                    ContentView()
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation {
                        showLoadScreen = false
                    }
                }
            }
        }
    }
}
