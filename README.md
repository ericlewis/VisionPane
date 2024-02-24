# VisionPane

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
