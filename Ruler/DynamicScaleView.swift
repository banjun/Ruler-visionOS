import SwiftUI

struct DynamicScaleView: View {
#if DEBUG
    @ObservedObject private var reloader = RulerApp.reloader
#endif

    @Environment(\.physicalMetrics) private var physicalMetrics

    var action: () -> Void

    var body: some View {
        VStack(alignment: .center) {
            VStack(alignment: .center) {
                Text("1 m = \(formatter.string(from: physicalMetrics.convert(1, from: .meters) as NSNumber)!) pt")
                    .foregroundStyle(.primary)
                Text("\(formatter.string(from: physicalMetrics.convert(60, to: .centimeters) as NSNumber)!) cm = 60 pt")
                    .foregroundStyle(.secondary)
                Text("\(formatter.string(from: 1564 / physicalMetrics.convert(1, from: .meters) as NSNumber)!)x")
                    .foregroundStyle(.tertiary)
            }
            .padding()

            Button("Physical Ruler", systemImage: "ruler", action: action)
                .padding()
        }
        .padding()
        .glassBackgroundEffect()
    }
}
