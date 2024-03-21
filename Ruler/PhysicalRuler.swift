import SwiftUI

struct PhysicalRuler: View {
    #if DEBUG
    @ObservedObject private var reloader = RulerApp.reloader
    #endif
    @Binding var cm: CGFloat
    @Environment(\.physicalMetrics) var physicalMetrics

    // private API
//    @State private var pointsPerMeter: CGFloat = 1564
//    @State private var effectivePointsPerMeter: CGFloat = 1564
//    @State private var timer: Timer?

    var body: some View {
        VStack(alignment: .center) {
            ZStack {
                Rectangle()
                    .fill(Color.white)
                    .frame(width: physicalMetrics.convert(cm, from: .centimeters),
                           height: physicalMetrics.convert(5, from: .centimeters))
                    .animation(.spring, value: cm)
                    .overlay {
                        scale()
                    }

//                Text("1m = \(formatter.string(from: .init(value: effectivePointsPerMeter))!) pt")
                Text("\(formatter.string(from: .init(value: cm))!) cm = \(formatter.string(from: .init(value: physicalMetrics.convert(cm, from: .centimeters)))!) pt")
                    .foregroundColor(Color.black).opacity(0.2)
            }

            Picker("Length", selection: $cm) {
                // NOTE: 300cm may not work for a volumetric window.
                // for visionOS 1.1, the Window Zoom system settings & volumetric upper bound are below:
                //       Small: 1836pt/m, < 148cm (~2717pt)
                //      Medium: 1564pt/m, < 173cm (~2706pt)
                //       Large: 1360pt/m, < 199cm (~2706pt)
                // Extra Large: 1156pt/m, < 234cm (~2705pt)
                ForEach([CGFloat]([10, 15, 20, 30, 50, 100, 200, 300]), id: \.self) {
                    Text("\(formatter.string(from: .init(value: $0))!) cm").tag($0)
                }
            }
            .pickerStyle(.wheel).frame(height: 50)
            .fixedSize()
        }
        .onAppear {
//            self.timer = Timer(timeInterval: 1, repeats: true) { _ in
//                let windowScenes = UIApplication.shared.connectedScenes.compactMap { $0 as? UIWindowScene }
//                let settings: NSObject? = windowScenes
//                    .first { $0.debugDescription.contains("role: UIWindowSceneSessionRoleVolumetricApplication") }.flatMap {
//                        ($0 as NSObject).value(forKey: "scene") as? NSObject
//                    }.flatMap {
//                        ($0 as NSObject).value(forKey: "settings") as? NSObject
//                    }
////                    .flatMap {
////                        ($0 as NSObject).value(forKey: "subclassSettings") as? NSObject
////                    }
//                guard let settings else { return }
//                if let pointsPerMeter = (settings.value(forKey: "pointsPerMeter").flatMap { $0 as? CGFloat }) {
//                    self.pointsPerMeter = pointsPerMeter
//                }
//                if let effectivePointsPerMeter = (settings.value(forKey: "effectivePointsPerMeter").flatMap { $0 as? CGFloat }) {
//                    self.effectivePointsPerMeter = effectivePointsPerMeter
//                }
//            }
//            RunLoop.current.add(self.timer!, forMode: .common)
        }
        .onDisappear {
//            timer = nil
        }
    }

    private func scale() -> some View {
        GeometryReader { g in
            Group {
                ForEach(Array(0...Int(cm)), id: \.self) { x in
                    let width: CGFloat = 2
                    let height: CGFloat = x % 10 == 0 ? 20 : x % 5 == 0 ? 10 : 5
                    Rectangle()
                        .fill(Color.gray)
                        .frame(width: width, height: height)
                        .offset(x: physicalMetrics.convert(.init(x), from: .centimeters) - width / 2, y:0)
                    Rectangle()
                        .fill(Color.gray)
                        .frame(width: width, height: height)
                        .offset(x: physicalMetrics.convert(.init(x), from: .centimeters) - width / 2, y: g.size.height - height)
                }
            }
        }
    }
}

#Preview(windowStyle: .automatic) {
    PhysicalRuler(cm: .constant(20))
}
