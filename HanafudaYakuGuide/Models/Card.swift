import Foundation

// MARK: - Card Type

enum CardType: String, CaseIterable {
    case bright = "光"
    case animal = "種"
    case ribbon = "短冊"
    case plain = "粕"

    var displayName: String { rawValue }

    var points: Int {
        switch self {
        case .bright: return 20
        case .animal: return 10
        case .ribbon: return 5
        case .plain: return 1
        }
    }
}

// MARK: - Ribbon Type

enum RibbonType {
    case red    // 赤短 (January, February, March)
    case blue   // 青短 (June, September, October)
    case plain  // other ribbon cards
    case none   // non-ribbon cards
}

// MARK: - Hanafuda Card

struct HanafudaCard: Identifiable, Hashable {
    let id: String
    let month: Int
    let flower: String          // Japanese flower name: 松, 梅, etc.
    let flowerReading: String   // Pronunciation: まつ, うめ, etc.
    let type: CardType
    let name: String            // Card element name: 鶴, うぐいす, etc.
    let emoji: String           // Simplified visual representation
    let ribbonType: RibbonType

    func hash(into hasher: inout Hasher) { hasher.combine(id) }
    static func == (lhs: HanafudaCard, rhs: HanafudaCard) -> Bool { lhs.id == rhs.id }
}

// MARK: - All 48 Cards

extension HanafudaCard {
    static let allCards: [HanafudaCard] = january + february + march + april + may + june
        + july + august + september + october + november + december

    // Month 1 - 松 (Pine / January)
    private static let january: [HanafudaCard] = [
        HanafudaCard(id: "jan_crane",   month: 1, flower: "松", flowerReading: "まつ",
                     type: .bright, name: "鶴",   emoji: "🦢", ribbonType: .none),
        HanafudaCard(id: "jan_ribbon",  month: 1, flower: "松", flowerReading: "まつ",
                     type: .ribbon, name: "赤短", emoji: "📜", ribbonType: .red),
        HanafudaCard(id: "jan_plain1",  month: 1, flower: "松", flowerReading: "まつ",
                     type: .plain,  name: "カス", emoji: "🌲", ribbonType: .none),
        HanafudaCard(id: "jan_plain2",  month: 1, flower: "松", flowerReading: "まつ",
                     type: .plain,  name: "カス", emoji: "🌲", ribbonType: .none),
    ]

    // Month 2 - 梅 (Plum / February)
    private static let february: [HanafudaCard] = [
        HanafudaCard(id: "feb_warbler", month: 2, flower: "梅", flowerReading: "うめ",
                     type: .animal, name: "うぐいす", emoji: "🐦", ribbonType: .none),
        HanafudaCard(id: "feb_ribbon",  month: 2, flower: "梅", flowerReading: "うめ",
                     type: .ribbon, name: "赤短",    emoji: "📜", ribbonType: .red),
        HanafudaCard(id: "feb_plain1",  month: 2, flower: "梅", flowerReading: "うめ",
                     type: .plain,  name: "カス",    emoji: "🌸", ribbonType: .none),
        HanafudaCard(id: "feb_plain2",  month: 2, flower: "梅", flowerReading: "うめ",
                     type: .plain,  name: "カス",    emoji: "🌸", ribbonType: .none),
    ]

    // Month 3 - 桜 (Cherry / March)
    private static let march: [HanafudaCard] = [
        HanafudaCard(id: "mar_curtain", month: 3, flower: "桜", flowerReading: "さくら",
                     type: .bright, name: "幕",   emoji: "⛩️", ribbonType: .none),
        HanafudaCard(id: "mar_ribbon",  month: 3, flower: "桜", flowerReading: "さくら",
                     type: .ribbon, name: "赤短", emoji: "📜", ribbonType: .red),
        HanafudaCard(id: "mar_plain1",  month: 3, flower: "桜", flowerReading: "さくら",
                     type: .plain,  name: "カス", emoji: "🌸", ribbonType: .none),
        HanafudaCard(id: "mar_plain2",  month: 3, flower: "桜", flowerReading: "さくら",
                     type: .plain,  name: "カス", emoji: "🌸", ribbonType: .none),
    ]

    // Month 4 - 藤 (Wisteria / April)
    private static let april: [HanafudaCard] = [
        HanafudaCard(id: "apr_cuckoo",  month: 4, flower: "藤", flowerReading: "ふじ",
                     type: .animal, name: "不如帰", emoji: "🐦", ribbonType: .none),
        HanafudaCard(id: "apr_ribbon",  month: 4, flower: "藤", flowerReading: "ふじ",
                     type: .ribbon, name: "短冊",   emoji: "📜", ribbonType: .plain),
        HanafudaCard(id: "apr_plain1",  month: 4, flower: "藤", flowerReading: "ふじ",
                     type: .plain,  name: "カス",   emoji: "🪻", ribbonType: .none),
        HanafudaCard(id: "apr_plain2",  month: 4, flower: "藤", flowerReading: "ふじ",
                     type: .plain,  name: "カス",   emoji: "🪻", ribbonType: .none),
    ]

    // Month 5 - 菖蒲 (Iris / May)
    private static let may: [HanafudaCard] = [
        HanafudaCard(id: "may_bridge",  month: 5, flower: "菖蒲", flowerReading: "あやめ",
                     type: .animal, name: "八橋", emoji: "🌉", ribbonType: .none),
        HanafudaCard(id: "may_ribbon",  month: 5, flower: "菖蒲", flowerReading: "あやめ",
                     type: .ribbon, name: "短冊", emoji: "📜", ribbonType: .plain),
        HanafudaCard(id: "may_plain1",  month: 5, flower: "菖蒲", flowerReading: "あやめ",
                     type: .plain,  name: "カス", emoji: "💜", ribbonType: .none),
        HanafudaCard(id: "may_plain2",  month: 5, flower: "菖蒲", flowerReading: "あやめ",
                     type: .plain,  name: "カス", emoji: "💜", ribbonType: .none),
    ]

    // Month 6 - 牡丹 (Peony / June)
    private static let june: [HanafudaCard] = [
        HanafudaCard(id: "jun_butterfly", month: 6, flower: "牡丹", flowerReading: "ぼたん",
                     type: .animal, name: "蝶",   emoji: "🦋", ribbonType: .none),
        HanafudaCard(id: "jun_ribbon",    month: 6, flower: "牡丹", flowerReading: "ぼたん",
                     type: .ribbon, name: "青短", emoji: "📜", ribbonType: .blue),
        HanafudaCard(id: "jun_plain1",    month: 6, flower: "牡丹", flowerReading: "ぼたん",
                     type: .plain,  name: "カス", emoji: "🌹", ribbonType: .none),
        HanafudaCard(id: "jun_plain2",    month: 6, flower: "牡丹", flowerReading: "ぼたん",
                     type: .plain,  name: "カス", emoji: "🌹", ribbonType: .none),
    ]

    // Month 7 - 萩 (Bush Clover / July)
    private static let july: [HanafudaCard] = [
        HanafudaCard(id: "jul_boar",    month: 7, flower: "萩", flowerReading: "はぎ",
                     type: .animal, name: "猪",   emoji: "🐗", ribbonType: .none),
        HanafudaCard(id: "jul_ribbon",  month: 7, flower: "萩", flowerReading: "はぎ",
                     type: .ribbon, name: "短冊", emoji: "📜", ribbonType: .plain),
        HanafudaCard(id: "jul_plain1",  month: 7, flower: "萩", flowerReading: "はぎ",
                     type: .plain,  name: "カス", emoji: "🌿", ribbonType: .none),
        HanafudaCard(id: "jul_plain2",  month: 7, flower: "萩", flowerReading: "はぎ",
                     type: .plain,  name: "カス", emoji: "🌿", ribbonType: .none),
    ]

    // Month 8 - 芒 (Miscanthus / August)
    private static let august: [HanafudaCard] = [
        HanafudaCard(id: "aug_moon",    month: 8, flower: "芒", flowerReading: "すすき",
                     type: .bright, name: "月",   emoji: "🌕", ribbonType: .none),
        HanafudaCard(id: "aug_geese",   month: 8, flower: "芒", flowerReading: "すすき",
                     type: .animal, name: "雁",   emoji: "🪿", ribbonType: .none),
        HanafudaCard(id: "aug_plain1",  month: 8, flower: "芒", flowerReading: "すすき",
                     type: .plain,  name: "カス", emoji: "🌾", ribbonType: .none),
        HanafudaCard(id: "aug_plain2",  month: 8, flower: "芒", flowerReading: "すすき",
                     type: .plain,  name: "カス", emoji: "🌾", ribbonType: .none),
    ]

    // Month 9 - 菊 (Chrysanthemum / September)
    private static let september: [HanafudaCard] = [
        HanafudaCard(id: "sep_sake",    month: 9, flower: "菊", flowerReading: "きく",
                     type: .animal, name: "酒杯", emoji: "🍶", ribbonType: .none),
        HanafudaCard(id: "sep_ribbon",  month: 9, flower: "菊", flowerReading: "きく",
                     type: .ribbon, name: "青短", emoji: "📜", ribbonType: .blue),
        HanafudaCard(id: "sep_plain1",  month: 9, flower: "菊", flowerReading: "きく",
                     type: .plain,  name: "カス", emoji: "🌼", ribbonType: .none),
        HanafudaCard(id: "sep_plain2",  month: 9, flower: "菊", flowerReading: "きく",
                     type: .plain,  name: "カス", emoji: "🌼", ribbonType: .none),
    ]

    // Month 10 - 紅葉 (Maple / October)
    private static let october: [HanafudaCard] = [
        HanafudaCard(id: "oct_deer",    month: 10, flower: "紅葉", flowerReading: "もみじ",
                     type: .animal, name: "鹿",   emoji: "🦌", ribbonType: .none),
        HanafudaCard(id: "oct_ribbon",  month: 10, flower: "紅葉", flowerReading: "もみじ",
                     type: .ribbon, name: "青短", emoji: "📜", ribbonType: .blue),
        HanafudaCard(id: "oct_plain1",  month: 10, flower: "紅葉", flowerReading: "もみじ",
                     type: .plain,  name: "カス", emoji: "🍁", ribbonType: .none),
        HanafudaCard(id: "oct_plain2",  month: 10, flower: "紅葉", flowerReading: "もみじ",
                     type: .plain,  name: "カス", emoji: "🍁", ribbonType: .none),
    ]

    // Month 11 - 雨 (Rain / November)
    private static let november: [HanafudaCard] = [
        HanafudaCard(id: "nov_rainman", month: 11, flower: "雨", flowerReading: "あめ",
                     type: .bright, name: "小野道風", emoji: "☂️", ribbonType: .none),
        HanafudaCard(id: "nov_swallow", month: 11, flower: "雨", flowerReading: "あめ",
                     type: .animal, name: "燕",      emoji: "🕊️", ribbonType: .none),
        HanafudaCard(id: "nov_ribbon",  month: 11, flower: "雨", flowerReading: "あめ",
                     type: .ribbon, name: "短冊",     emoji: "📜", ribbonType: .plain),
        HanafudaCard(id: "nov_plain1",  month: 11, flower: "雨", flowerReading: "あめ",
                     type: .plain,  name: "カス",     emoji: "🌧️", ribbonType: .none),
    ]

    // Month 12 - 桐 (Paulownia / December)
    private static let december: [HanafudaCard] = [
        HanafudaCard(id: "dec_phoenix", month: 12, flower: "桐", flowerReading: "きり",
                     type: .bright, name: "鳳凰", emoji: "🦅", ribbonType: .none),
        HanafudaCard(id: "dec_plain1",  month: 12, flower: "桐", flowerReading: "きり",
                     type: .plain,  name: "カス", emoji: "🌺", ribbonType: .none),
        HanafudaCard(id: "dec_plain2",  month: 12, flower: "桐", flowerReading: "きり",
                     type: .plain,  name: "カス", emoji: "🌺", ribbonType: .none),
        HanafudaCard(id: "dec_plain3",  month: 12, flower: "桐", flowerReading: "きり",
                     type: .plain,  name: "カス", emoji: "🌺", ribbonType: .none),
    ]
}

// MARK: - Month Metadata

struct MonthInfo {
    let number: Int
    let flower: String
    let flowerReading: String
    let season: String

    static let all: [MonthInfo] = [
        MonthInfo(number: 1,  flower: "松",   flowerReading: "まつ",   season: "冬"),
        MonthInfo(number: 2,  flower: "梅",   flowerReading: "うめ",   season: "春"),
        MonthInfo(number: 3,  flower: "桜",   flowerReading: "さくら", season: "春"),
        MonthInfo(number: 4,  flower: "藤",   flowerReading: "ふじ",   season: "春"),
        MonthInfo(number: 5,  flower: "菖蒲", flowerReading: "あやめ", season: "夏"),
        MonthInfo(number: 6,  flower: "牡丹", flowerReading: "ぼたん", season: "夏"),
        MonthInfo(number: 7,  flower: "萩",   flowerReading: "はぎ",   season: "夏"),
        MonthInfo(number: 8,  flower: "芒",   flowerReading: "すすき", season: "秋"),
        MonthInfo(number: 9,  flower: "菊",   flowerReading: "きく",   season: "秋"),
        MonthInfo(number: 10, flower: "紅葉", flowerReading: "もみじ", season: "秋"),
        MonthInfo(number: 11, flower: "雨",   flowerReading: "あめ",   season: "冬"),
        MonthInfo(number: 12, flower: "桐",   flowerReading: "きり",   season: "冬"),
    ]
}
