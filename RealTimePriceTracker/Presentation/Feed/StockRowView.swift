import SwiftUI

struct StockRowView: View {
    
    let stock: StockRowState

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(stock.symbol)
                    .font(.headline)
            }

            Spacer()

            VStack(alignment: .trailing) {
                Text(String(format: "%.2f", stock.price))
                    .monospacedDigit()

                HStack(spacing: 4) {
                    Image(systemName: stock.isUp ? "arrow.up" : "arrow.down")
                        .foregroundStyle(stock.isUp ? .green : .red)

                    Text(stock.isUp ? "Up" : "Down")
                        .font(.caption)
                        .foregroundStyle(stock.isUp ? .green : .red)
                }
            }
        }.listRowBackground(
            stock.isFlashingUp ? Color.green.opacity(0.2):
                stock.isFlashingDown ? Color.red.opacity(0.2):
                Color.clear
        )
        .animation(.easeOut(duration: 0.25), value: stock.isFlashingUp)
                .animation(.easeOut(duration: 0.25), value: stock.isFlashingDown)
    }
}
