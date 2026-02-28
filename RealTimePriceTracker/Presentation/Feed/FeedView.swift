import SwiftUI

struct FeedView: View {
    @ObservedObject var viewModel: FeedViewModel
    let makeDetail: (String) -> DetailViewModel
    
    var body: some View {
        List(viewModel.stocks) { stock in
            NavigationLink {
                DetailView(viewModel: makeDetail(stock.symbol))
            } label: {
                StockRowView(stock: stock)
            }
        }
        .navigationTitle("Price Tracker")
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                HStack {
                    Image(systemName: viewModel.connectionState.systemImage)
                        .font(.system(size: 10))
                        .foregroundStyle(viewModel.connectionState.color)
                    Text(viewModel.connectionState.displayText)
                        .font(.caption)
                }
               
            }

            ToolbarItem(placement: .topBarTrailing) {
                Button(viewModel.isRunning ? "Stop" : "Start") {
                    viewModel.toggle()
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(viewModel.isRunning ? .red: .blue)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
    }
}

#Preview {
    NavigationStack {
        FeedView(
            viewModel: FeedPreview.makeVM(),
            makeDetail: { DetailPreview.makeVM(symbol: $0) }
        )
    }
}
