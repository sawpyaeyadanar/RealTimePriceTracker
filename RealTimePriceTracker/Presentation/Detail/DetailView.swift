import SwiftUI

struct DetailView: View {
    @ObservedObject var viewModel: DetailViewModel
    
    var body: some View {
        VStack(alignment: .leading,spacing: 12) {
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
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.white)))
            
            
            VStack {
                Text(viewModel.stock?.description ?? "")
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

#Preview  {
    DetailView(viewModel: DetailPreview.makeVM())
}

