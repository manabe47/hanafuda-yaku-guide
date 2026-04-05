import Foundation

// MARK: - Role Detector

enum RoleDetector {

    /// Returns the final point value for a completed role given the current selection.
    static func points(for role: KoiKoiRole, selected: Set<String>, cards: [HanafudaCard]) -> Int {
        guard role.check(selected, cards) else { return 0 }
        guard role.isVariable else { return role.basePoints }

        switch role.id {
        case "tan":
            let count = cards.filter { selected.contains($0.id) && $0.type == .ribbon }.count
            return role.basePoints + max(0, count - 5)
        case "tane":
            let count = cards.filter { selected.contains($0.id) && $0.type == .animal }.count
            return role.basePoints + max(0, count - 5)
        case "kasu":
            let count = cards.filter { selected.contains($0.id) && $0.type == .plain }.count
            return role.basePoints + max(0, count - 10)
        default:
            return role.basePoints
        }
    }

    /// Returns all completed roles for the given card selection.
    static func completedRoles(
        selected: Set<String>,
        cards: [HanafudaCard],
        roles: [KoiKoiRole]
    ) -> [KoiKoiRole] {
        roles.filter { $0.check(selected, cards) }
    }

    /// Total score from all completed roles.
    static func totalScore(
        selected: Set<String>,
        cards: [HanafudaCard],
        roles: [KoiKoiRole]
    ) -> Int {
        completedRoles(selected: selected, cards: cards, roles: roles)
            .reduce(0) { $0 + points(for: $1, selected: selected, cards: cards) }
    }
}
