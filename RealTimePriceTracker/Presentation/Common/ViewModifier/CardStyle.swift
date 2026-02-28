import SwiftUI

struct CardStyle: ViewModifier {

    private var cardBackground: Color {
        Color(
            UIColor { trait in
                trait.userInterfaceStyle == .dark
                ? UIColor.secondarySystemBackground
                : UIColor.white
            }
        )
    }

    func body(content: Content) -> some View {
        content
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(cardBackground)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color(.separator), lineWidth: 0.5)
            )
    }
}

extension View {
    func cardStyle() -> some View {
        modifier(CardStyle())
    }
}


#Preview {
    VStack(spacing: 16) {
        Text("Content")
            .cardStyle()
    }
    .padding()
    .background(Color(.systemGroupedBackground))
    //.preferredColorScheme(.light)
    .preferredColorScheme(.dark)
}
