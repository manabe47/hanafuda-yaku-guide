import SwiftUI

// MARK: - Card View

struct CardView: View {
    let card: HanafudaCard
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(isSelected ? Color(.systemGray4) : cardBackgroundColor)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .strokeBorder(isSelected ? Color(.systemGray3) : borderColor, lineWidth: 2)
                    )

                VStack(spacing: 4) {
                    Text(card.emoji)
                        .font(.system(size: 28))
                        .grayscale(isSelected ? 1.0 : 0.0)

                    Text(card.name)
                        .font(.system(size: 11, weight: .medium, design: .rounded))
                        .foregroundColor(isSelected ? Color(.systemGray) : nameColor)
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)

                    Text(card.type.displayName)
                        .font(.system(size: 9, weight: .regular))
                        .foregroundColor(isSelected ? Color(.systemGray3) : typeColor)
                }
                .padding(6)

                // Checkmark overlay when selected
                if isSelected {
                    VStack {
                        HStack {
                            Spacer()
                            Image(systemName: "checkmark.circle.fill")
                                .font(.system(size: 14))
                                .foregroundColor(Color(.systemGray2))
                                .padding(4)
                        }
                        Spacer()
                    }
                }
            }
        }
        .buttonStyle(CardButtonStyle())
        .frame(height: 90)
    }

    // MARK: Colors

    private var cardBackgroundColor: Color {
        switch card.type {
        case .bright: return Color(red: 1.0, green: 0.95, blue: 0.8)  // Warm gold tint
        case .animal: return Color(red: 0.9, green: 1.0, blue: 0.9)   // Light green tint
        case .ribbon: return ribbonBackgroundColor
        case .plain:  return Color(red: 0.97, green: 0.95, blue: 0.92) // Warm cream
        }
    }

    private var ribbonBackgroundColor: Color {
        switch card.ribbonType {
        case .red:   return Color(red: 1.0, green: 0.92, blue: 0.92)   // Light red tint
        case .blue:  return Color(red: 0.9, green: 0.93, blue: 1.0)    // Light blue tint
        case .plain: return Color(red: 0.95, green: 0.9, blue: 1.0)    // Light purple tint
        case .none:  return Color(red: 0.97, green: 0.95, blue: 0.92)
        }
    }

    private var borderColor: Color {
        switch card.type {
        case .bright: return Color(red: 0.8, green: 0.65, blue: 0.1)   // Gold
        case .animal: return Color(red: 0.3, green: 0.6, blue: 0.3)    // Green
        case .ribbon: return ribbonBorderColor
        case .plain:  return Color(.systemGray4)
        }
    }

    private var ribbonBorderColor: Color {
        switch card.ribbonType {
        case .red:   return Color(red: 0.75, green: 0.1, blue: 0.1)    // Crimson
        case .blue:  return Color(red: 0.1, green: 0.2, blue: 0.7)     // Navy
        case .plain: return Color(red: 0.45, green: 0.2, blue: 0.6)    // Purple
        case .none:  return Color(.systemGray4)
        }
    }

    private var nameColor: Color {
        switch card.type {
        case .bright: return Color(red: 0.5, green: 0.35, blue: 0.0)
        case .animal: return Color(red: 0.1, green: 0.4, blue: 0.1)
        case .ribbon: return ribbonNameColor
        case .plain:  return Color(.systemGray)
        }
    }

    private var ribbonNameColor: Color {
        switch card.ribbonType {
        case .red:   return Color(red: 0.7, green: 0.1, blue: 0.1)
        case .blue:  return Color(red: 0.1, green: 0.2, blue: 0.65)
        case .plain: return Color(red: 0.4, green: 0.15, blue: 0.55)
        case .none:  return Color(.systemGray)
        }
    }

    private var typeColor: Color { Color(.systemGray2) }
}

// MARK: - Card Button Style

struct CardButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.94 : 1.0)
            .animation(.easeInOut(duration: 0.12), value: configuration.isPressed)
    }
}

// MARK: - Preview

#Preview {
    HStack {
        CardView(
            card: HanafudaCard.allCards[0],
            isSelected: false,
            onTap: {}
        )
        CardView(
            card: HanafudaCard.allCards[0],
            isSelected: true,
            onTap: {}
        )
    }
    .padding()
    .background(Color(red: 0.96, green: 0.93, blue: 0.87))
}
