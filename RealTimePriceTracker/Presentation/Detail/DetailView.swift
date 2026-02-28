import SwiftUI

struct DetailView: View {
    @ObservedObject var viewModel: DetailViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            VStack(alignment: .leading, spacing: 16) {
                if let stock = viewModel.stock {
                    Text(stock.symbol)
                        .font(.largeTitle)
                        .bold()

                    Text("Price: \(String(format: "%.2f", stock.price))")
                        .font(.title2)
                        .monospacedDigit()

                    HStack {
                        Image(systemName: stock.isUp ? "arrow.up" : "arrow.down")
                            .foregroundStyle(stock.isUp ? .green : .red)

                        Text(stock.isUp ? "Up" : "Down")
                            .foregroundStyle(stock.isUp ? .green : .red)
                    }
                } else {
                    Text("Loading...")
                        .foregroundStyle(.secondary)
                }
            }
            .cardStyle()

            Text(viewModel.stock?.description ?? "")
                .cardStyle()

            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color(.systemGroupedBackground))
    }
}

#Preview  {
    DetailView(viewModel: DetailPreview.makeVM())
        .preferredColorScheme(.dark)
}

