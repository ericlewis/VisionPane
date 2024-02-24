# VisionPane

https://github.com/ericlewis/VisionPane/assets/674503/5cb4d4ef-5da8-4aaf-8345-62fe26e5b90f

## Code
```swift
import SwiftUI
import VisionPane

struct PaneView: View {
    
    @Environment(\.dismissPane)
    var dismissPane
    
    var body: some View {
        NavigationStack {
            List {
                Text("Item 1")
            }
            .toolbar {
                Button("Dismiss", systemImage: "xmark") {
                    dismissPane()
                }
            }
            .navigationTitle("Pane")
        }
    }
}

struct ContentView: View {
    
    @State
    private var isPanePresented = false
    
    var body: some View {
        NavigationStack {
            List {
                Button("Toggle Pane") {
                    isPanePresented.toggle()
                }
            }
        }
        .pane(isPresented: $isPanePresented) {
            PaneView()
        }
    }
}

@main
struct ExampleApp: App {
    var body: some Scene {
        WindowGroup.Pane {
            ContentView()
        }
    }
}
```
