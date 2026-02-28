import SwiftUI

struct FeedView: View {
    let items: [Stock] = [
        Stock(symbol: "AAPL", description: "Apple", price: 1.234, previousPrice: 432.2)]
    var body: some View {
        List(items) { stock in
            StockRowView(stock: stock)
        }
        .navigationTitle("Price Tracker")
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                HStack {
                    Image(systemName: "circle.fill")
                        .font(.system(size: 10))
                        .foregroundStyle(.green)
                    Text("Connected")
                        .font(.caption)
                }
               
            }

            ToolbarItem(placement: .topBarTrailing) {
                Button("Stop") {
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(.red)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
    }
}


#Preview(body: {
    NavigationStack {
            FeedView()
        }
})
