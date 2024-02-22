import SwiftUI

@main
struct RulerApp: App {
    @AppStorage("cm") private var cm: Double = 20

    var body: some Scene {
        WindowGroup {
            ContentView(cm: .init(get: {.init(cm)}, set: {cm = .init($0)}))
        }.windowStyle(.volumetric)
            .defaultSize(.init(width: 30, height: 5, depth: 0), in: .centimeters)
            .windowResizability(.contentMinSize)
    }
}
