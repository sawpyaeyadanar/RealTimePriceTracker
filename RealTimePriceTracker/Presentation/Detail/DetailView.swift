import SwiftUI

struct DetailView: View {
    let stock = Stock(symbol: "AAPL", description: "Apple", price: 1.234, previousPrice: 432.2)
    var body: some View {
        VStack(alignment: .leading,spacing: 12) {
            VStack(alignment: .leading, spacing: 16) {
                
                    
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
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.white)))
            
            
            VStack {
                Text("Apple")
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(.white)))
            }
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGray6))
    }
}

#Preview {
    DetailView()
}
