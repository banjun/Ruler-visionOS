import SwiftUI
import Ruler

extension PhysicalRuler {
//    @_dynamicReplacement(for: body)
//    var body2: some View {
//        Text("dynamically replaced!!!")
//    }
    @_dynamicReplacement(for: scale)
    func scale2() -> some View {
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
