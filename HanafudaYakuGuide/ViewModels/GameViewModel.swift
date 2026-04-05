import SwiftUI

// MARK: - Game View Model

@MainActor
final class GameViewModel: ObservableObject {

    // MARK: Published State
    @Published private(set) var selectedCardIds: Set<String> = []
    @Published private(set) var completedRoles: [KoiKoiRole] = []
    @Published var selectedMonth: Int = 1

    // MARK: Data
    let allCards: [HanafudaCard] = HanafudaCard.allCards
    let allRoles: [KoiKoiRole] = KoiKoiRole.allRoles
    let months: [MonthInfo] = MonthInfo.all

    // MARK: Derived
    var cardsByMonth: [Int: [HanafudaCard]] {
        Dictionary(grouping: allCards, by: { $0.month })
    }

    var currentMonthCards: [HanafudaCard] {
        cardsByMonth[selectedMonth] ?? []
    }

    var totalScore: Int {
        RoleDetector.totalScore(selected: selectedCardIds, cards: allCards, roles: allRoles)
    }

    var selectedCount: Int { selectedCardIds.count }

    // MARK: Actions

    func toggleCard(_ card: HanafudaCard) {
        if selectedCardIds.contains(card.id) {
            selectedCardIds.remove(card.id)
        } else {
            selectedCardIds.insert(card.id)
        }
        updateRoles()
    }

    func isSelected(_ card: HanafudaCard) -> Bool {
        selectedCardIds.contains(card.id)
    }

    func selectMonth(_ month: Int) {
        selectedMonth = month
    }

    func reset() {
        selectedCardIds = []
        completedRoles = []
    }

    func points(for role: KoiKoiRole) -> Int {
        RoleDetector.points(for: role, selected: selectedCardIds, cards: allCards)
    }

    // MARK: Private

    private func updateRoles() {
        completedRoles = RoleDetector.completedRoles(
            selected: selectedCardIds,
            cards: allCards,
            roles: allRoles
        )
    }
}
