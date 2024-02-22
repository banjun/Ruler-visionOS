import SwiftUI

struct ContentView: View {
    @Binding var cm: CGFloat
    @Environment(\.physicalMetrics) var physicalMetrics

    private let formatter: NumberFormatter = {
        let f = NumberFormatter()
        f.minimumFractionDigits = 1
        f.maximumFractionDigits = 1
        return f
    }()

    var body: some View {
        VStack(alignment: .center) {
            Rectangle()
                .fill(Color.white)
                .frame(width: physicalMetrics.convert(cm, from: .centimeters),
                       height: physicalMetrics.convert(5, from: .centimeters))
                .animation(.spring, value: cm)

            Picker("Length", selection: $cm) {
                // NOTE: 300cm may not work for a volumetric window
                ForEach([CGFloat]([10, 15, 20, 30, 50, 100, 200, 300]), id: \.self) {
                    Text("\(formatter.string(from: .init(value: $0))!) cm").tag($0)
                }
            }
            .pickerStyle(.wheel).frame(height: 50)
            .fixedSize()
        }        
    }
}

#Preview(windowStyle: .automatic) {
    ContentView(cm: .constant(20))
}
