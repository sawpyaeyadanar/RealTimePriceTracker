import Foundation

struct StockRowState: Identifiable {
    let id: String
    let symbol: String
    let description: String
    let price: Double
    let isUp: Bool
    let isFlashingUp: Bool
    let isFlashingDown: Bool
    
    static func from(stock: Stock) -> StockRowState {
        StockRowState(
            id: stock.symbol,
            symbol: stock.symbol,
            description: stock.description,
            price: stock.price,
            isUp: stock.isUp,
            isFlashingUp: false,
            isFlashingDown: false
        )
    }
}
