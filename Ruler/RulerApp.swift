import SwiftUI

#if DEBUG
import SwiftHotReload
extension RulerApp {
    static let reloader = ProxyReloader(.init(targetSwiftFile: URL(filePath: #filePath).deletingLastPathComponent().appendingPathComponent("RuntimeOverrides.swift")))
}
#endif

let formatter: NumberFormatter = {
    let f = NumberFormatter()
    f.minimumFractionDigits = 1
    f.maximumFractionDigits = 1
    return f
}()

@main
struct RulerApp: App {
    @AppStorage("cm") private var cm: Double = 20
    @Environment(\.openWindow) private var openWindow

    var body: some Scene {
        WindowGroup(id: "Plain") {
            VStack {
                Text("Dynamic Scale")
                    .font(.title)

                DynamicScaleView {
                    openWindow(id: "Volumetric")
                }
            }
            .frame(minWidth: 275, maxWidth: 275, minHeight: 275, maxHeight: 275)
        }.windowStyle(.plain)
            .windowResizability(.contentSize)

        WindowGroup(id: "Volumetric") {
            PhysicalRuler(cm: $cm.cgfloat)
                .frame(minDepth: 1, maxDepth: 1, alignment: .front)
        }.windowStyle(.volumetric)
            .defaultSize(.init(width: 30, height: 5, depth: 0), in: .centimeters)
            .windowResizability(.contentMinSize)

//        Self.reloader.windowGroupForAlert
    }
}

extension Binding<Double> {
    var cgfloat: Binding<CGFloat> {
        .init(get: { .init(wrappedValue) }, set: { wrappedValue = .init($0) })
    }
}
