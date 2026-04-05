import Foundation

// MARK: - Koikoi Role

struct KoiKoiRole: Identifiable {
    let id: String
    let name: String            // Japanese name
    let nameRomaji: String      // Romaji transliteration
    let description: String     // What cards form this role
    let basePoints: Int
    let isVariable: Bool        // true if points increase with extra cards
    let requiredCardIds: [String] // specific card IDs involved (for highlighting)
    let check: (Set<String>, [HanafudaCard]) -> Bool

    init(
        id: String,
        name: String,
        nameRomaji: String,
        description: String,
        basePoints: Int,
        isVariable: Bool = false,
        requiredCardIds: [String] = [],
        check: @escaping (Set<String>, [HanafudaCard]) -> Bool
    ) {
        self.id = id
        self.name = name
        self.nameRomaji = nameRomaji
        self.description = description
        self.basePoints = basePoints
        self.isVariable = isVariable
        self.requiredCardIds = requiredCardIds
        self.check = check
    }
}

// MARK: - All Koikoi Roles

extension KoiKoiRole {

    static let allRoles: [KoiKoiRole] = [
        gokou,
        shikou,
        ameShikou,
        sankou,
        tsukimiZake,
        hanamizake,
        inoshikacho,
        aotan,
        akatan,
        tan,
        tane,
        kasu,
    ]

    // MARK: Bright Roles

    /// 五光 - All 5 bright cards
    static let gokou = KoiKoiRole(
        id: "gokou",
        name: "五光",
        nameRomaji: "Gokō",
        description: "5枚の光札すべて",
        basePoints: 10,
        requiredCardIds: ["jan_crane", "mar_curtain", "aug_moon", "nov_rainman", "dec_phoenix"],
        check: { selected, _ in
            ["jan_crane", "mar_curtain", "aug_moon", "nov_rainman", "dec_phoenix"]
                .allSatisfy { selected.contains($0) }
        }
    )

    /// 四光 - 4 brights NOT including Rain Man
    static let shikou = KoiKoiRole(
        id: "shikou",
        name: "四光",
        nameRomaji: "Shikō",
        description: "雨以外の光札4枚",
        basePoints: 8,
        requiredCardIds: ["jan_crane", "mar_curtain", "aug_moon", "dec_phoenix"],
        check: { selected, _ in
            let nonRain = ["jan_crane", "mar_curtain", "aug_moon", "dec_phoenix"]
            return nonRain.allSatisfy { selected.contains($0) }
        }
    )

    /// 雨四光 - Rain Man + any 3 non-rain brights
    static let ameShikou = KoiKoiRole(
        id: "ame_shikou",
        name: "雨四光",
        nameRomaji: "Ameshikō",
        description: "雨の光札を含む光札4枚",
        basePoints: 7,
        requiredCardIds: ["nov_rainman"],
        check: { selected, _ in
            guard selected.contains("nov_rainman") else { return false }
            let nonRain = ["jan_crane", "mar_curtain", "aug_moon", "dec_phoenix"]
            let count = nonRain.filter { selected.contains($0) }.count
            return count >= 3
        }
    )

    /// 三光 - Any 3 non-rain brights (but not 4+)
    static let sankou = KoiKoiRole(
        id: "sankou",
        name: "三光",
        nameRomaji: "Sankō",
        description: "雨以外の光札3枚",
        basePoints: 5,
        requiredCardIds: [],
        check: { selected, _ in
            let nonRain = ["jan_crane", "mar_curtain", "aug_moon", "dec_phoenix"]
            let count = nonRain.filter { selected.contains($0) }.count
            return count == 3 && !selected.contains("nov_rainman")
        }
    )

    // MARK: Special Combination Roles

    /// 月見酒 - Full Moon + Sake Cup
    static let tsukimiZake = KoiKoiRole(
        id: "tsukimi_zake",
        name: "月見酒",
        nameRomaji: "Tsukimizake",
        description: "芒の月 + 菊の酒杯",
        basePoints: 3,
        requiredCardIds: ["aug_moon", "sep_sake"],
        check: { selected, _ in
            selected.contains("aug_moon") && selected.contains("sep_sake")
        }
    )

    /// 花見酒 - Cherry Curtain + Sake Cup
    static let hanamizake = KoiKoiRole(
        id: "hanami_zake",
        name: "花見酒",
        nameRomaji: "Hanamizake",
        description: "桜の幕 + 菊の酒杯",
        basePoints: 3,
        requiredCardIds: ["mar_curtain", "sep_sake"],
        check: { selected, _ in
            selected.contains("mar_curtain") && selected.contains("sep_sake")
        }
    )

    // MARK: Animal Combination Role

    /// 猪鹿蝶 - Boar + Deer + Butterfly
    static let inoshikacho = KoiKoiRole(
        id: "inoshikacho",
        name: "猪鹿蝶",
        nameRomaji: "Inoshikachō",
        description: "萩の猪 + 紅葉の鹿 + 牡丹の蝶",
        basePoints: 5,
        requiredCardIds: ["jul_boar", "oct_deer", "jun_butterfly"],
        check: { selected, _ in
            selected.contains("jul_boar") &&
            selected.contains("oct_deer") &&
            selected.contains("jun_butterfly")
        }
    )

    // MARK: Ribbon Roles

    /// 青短 - 3 blue ribbons (Peony, Chrysanthemum, Maple)
    static let aotan = KoiKoiRole(
        id: "aotan",
        name: "青短",
        nameRomaji: "Aotan",
        description: "牡丹・菊・紅葉の青い短冊3枚",
        basePoints: 5,
        requiredCardIds: ["jun_ribbon", "sep_ribbon", "oct_ribbon"],
        check: { selected, _ in
            selected.contains("jun_ribbon") &&
            selected.contains("sep_ribbon") &&
            selected.contains("oct_ribbon")
        }
    )

    /// 赤短 - 3 red poem ribbons (Pine, Plum, Cherry)
    static let akatan = KoiKoiRole(
        id: "akatan",
        name: "赤短",
        nameRomaji: "Akatan",
        description: "松・梅・桜の赤い短冊3枚",
        basePoints: 5,
        requiredCardIds: ["jan_ribbon", "feb_ribbon", "mar_ribbon"],
        check: { selected, _ in
            selected.contains("jan_ribbon") &&
            selected.contains("feb_ribbon") &&
            selected.contains("mar_ribbon")
        }
    )

    // MARK: Count-Based Roles

    /// たん - 5 or more ribbon cards
    static let tan = KoiKoiRole(
        id: "tan",
        name: "たん",
        nameRomaji: "Tan",
        description: "短冊5枚以上 (超過1枚ごと+1点)",
        basePoints: 1,
        isVariable: true,
        check: { selected, cards in
            let count = cards.filter { selected.contains($0.id) && $0.type == .ribbon }.count
            return count >= 5
        }
    )

    /// タネ - 5 or more animal cards
    static let tane = KoiKoiRole(
        id: "tane",
        name: "タネ",
        nameRomaji: "Tane",
        description: "種札5枚以上 (超過1枚ごと+1点)",
        basePoints: 1,
        isVariable: true,
        check: { selected, cards in
            let count = cards.filter { selected.contains($0.id) && $0.type == .animal }.count
            return count >= 5
        }
    )

    /// 粕 - 10 or more plain cards
    static let kasu = KoiKoiRole(
        id: "kasu",
        name: "粕",
        nameRomaji: "Kasu",
        description: "カス10枚以上 (超過1枚ごと+1点)",
        basePoints: 1,
        isVariable: true,
        check: { selected, cards in
            let count = cards.filter { selected.contains($0.id) && $0.type == .plain }.count
            return count >= 10
        }
    )
}
