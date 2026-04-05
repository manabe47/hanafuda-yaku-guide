import SwiftUI

// MARK: - Month Tab Bar

struct MonthTabBar: View {
    @ObservedObject var viewModel: GameViewModel

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 4), count: 6)

    var body: some View {
        LazyVGrid(columns: columns, spacing: 4) {
            ForEach(1...12, id: \.self) { month in
                MonthTabButton(
                    month: month,
                    info: MonthInfo.all[month - 1],
                    isSelected: viewModel.selectedMonth == month,
                    hasSelectedCards: hasSelectedCards(in: month)
                ) {
                    viewModel.selectMonth(month)
                }
            }
        }
        .padding(.horizontal, 12)
    }

    private func hasSelectedCards(in month: Int) -> Bool {
        (viewModel.cardsByMonth[month] ?? []).contains { viewModel.isSelected($0) }
    }
}

// MARK: - Month Tab Button

struct MonthTabButton: View {
    let month: Int
    let info: MonthInfo
    let isSelected: Bool
    let hasSelectedCards: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 1) {
                Text(info.flower)
                    .font(.system(size: 15, weight: isSelected ? .bold : .regular))
                    .foregroundColor(isSelected ? .white : Color(red: 0.3, green: 0.15, blue: 0.05))

                Text("\(month)月")
                    .font(.system(size: 9, weight: .medium))
                    .foregroundColor(isSelected ? .white.opacity(0.85) : Color(.systemGray2))
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 6)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(isSelected ? Color(red: 0.55, green: 0.2, blue: 0.05) : Color(red: 0.93, green: 0.88, blue: 0.80))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(
                        isSelected
                            ? Color(red: 0.55, green: 0.2, blue: 0.05)
                            : (hasSelectedCards ? Color(red: 0.75, green: 0.45, blue: 0.2) : Color.clear),
                        lineWidth: hasSelectedCards && !isSelected ? 1.5 : 0
                    )
            )
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Month Card Grid

struct MonthCardGrid: View {
    @ObservedObject var viewModel: GameViewModel

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 2)

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Month header
            HStack {
                let info = MonthInfo.all[viewModel.selectedMonth - 1]
                Text(info.flower)
                    .font(.system(size: 22, weight: .bold, design: .rounded))
                    .foregroundColor(Color(red: 0.4, green: 0.15, blue: 0.02))
                Text("(\(info.flowerReading))")
                    .font(.system(size: 14))
                    .foregroundColor(Color(.systemGray))
                Spacer()
                Text("\(viewModel.selectedMonth)月")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(Color(.systemGray2))
            }
            .padding(.horizontal, 12)

            // 2×2 card grid
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(viewModel.currentMonthCards) { card in
                    CardView(
                        card: card,
                        isSelected: viewModel.isSelected(card),
                        onTap: { viewModel.toggleCard(card) }
                    )
                }
            }
            .padding(.horizontal, 12)
        }
    }
}

// MARK: - Preview

#Preview {
    let vm = GameViewModel()
    return VStack {
        MonthTabBar(viewModel: vm)
        MonthCardGrid(viewModel: vm)
    }
    .background(Color(red: 0.96, green: 0.93, blue: 0.87))
}
