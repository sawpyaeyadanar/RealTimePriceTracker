import SwiftUI

extension ConnectionState {
    var displayText: String {
        switch self {
        case .disconnected:
            "Disconnected"
        case .connecting:
            "Connecting..."
        case .connected:
            "Connected"
        case .failed(let string):
            "Failed"
        }
    }
    
    var color: Color {
        switch self {
        case .disconnected:
                .red
        case .connecting:
                .orange
        case .connected:
                .green
        case .failed(_):
                .red
        }
    }
    
    var systemImage: String {
        switch self {
        case .disconnected:
            "circle.fill"
        case .connecting:
            "arrow.triangle.2.circlepath"
        case .connected:
            "circle.fill"
        case .failed(let string):
            "xmark.circle.fill"
        }
    }
}
