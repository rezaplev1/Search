import Foundation

struct Products: Codable {
    let status: Status?
    let header: Header?
    let data: [DatumElement]?
    let category: Category?
}

struct Category: Codable {
    let data: [String: DatumValue]?
    let selectedID: String?
    
    enum CodingKeys: String, CodingKey {
        case data
        case selectedID = "selected_id"
    }
}

struct DatumValue: Codable {
    let id: Int?
    let name, totalData: String?
    let parentID: Int?
    let childID: [Int]?
    let level: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case totalData = "total_data"
        case parentID = "parent_id"
        case childID = "child_id"
        case level
    }
}

struct DatumElement: Codable {
    let id: Int?
    let name: String?
    let uri: String?
    let imageURI, imageURI700: String?
    let price, priceRange, categoryBreadcrumb: String?
    let shop: Shop?
    let wholesalePrice: [WholesalePrice]?
    let condition, preorder, departmentID, rating: Int?
    let isFeatured, countReview, countTalk, countSold: Int?
    let originalPrice, discountExpired, discountStart: String?
    let discountPercentage, stock: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, name, uri
        case imageURI = "image_uri"
        case imageURI700 = "image_uri_700"
        case price
        case priceRange = "price_range"
        case categoryBreadcrumb = "category_breadcrumb"
        case shop
        case wholesalePrice = "wholesale_price"
        case condition, preorder
        case departmentID = "department_id"
        case rating
        case isFeatured = "is_featured"
        case countReview = "count_review"
        case countTalk = "count_talk"
        case countSold = "count_sold"
        case originalPrice = "original_price"
        case discountExpired = "discount_expired"
        case discountStart = "discount_start"
        case discountPercentage = "discount_percentage"
        case stock
    }
}

struct Badge: Codable {
    let title: BadgeTitle?
    let imageURL: String?
    let show: Bool?
    
    enum CodingKeys: String, CodingKey {
        case title
        case imageURL = "image_url"
        case show
    }
}

enum BadgeTitle: String, Codable {
    case goldMerchant = "Gold Merchant"
}

struct Label: Codable {
    let title: LabelTitle?
    let color: Color?
}

enum Color: String, Codable {
    case ffffff = "#ffffff"
    case the42B549 = "#42b549"
}

enum LabelTitle: String, Codable {
    case cashback5 = "Cashback 5%"
    case grosir = "Grosir"
}

struct Shop: Codable {
    let id: Int?
    let name: String?
    let uri: String?
    let isGold: Int?
    let location: String?
    let reputationImageURI, shopLucky: String?
    let city: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, uri
        case isGold = "is_gold"
        case location
        case reputationImageURI = "reputation_image_uri"
        case shopLucky = "shop_lucky"
        case city
    }
}

struct WholesalePrice: Codable {
    let countMin, countMax: Int?
    let price: String?
    
    enum CodingKeys: String, CodingKey {
        case countMin = "count_min"
        case countMax = "count_max"
        case price
    }
}

struct Header: Codable {
    let totalData, totalDataNoCategory: Int?
    let additionalParams: String?
    let processTime: Double?
    
    enum CodingKeys: String, CodingKey {
        case totalData = "total_data"
        case totalDataNoCategory = "total_data_no_category"
        case additionalParams = "additional_params"
        case processTime = "process_time"
    }
}

struct Status: Codable {
    let errorCode: Int?
    let message: String?
    
    enum CodingKeys: String, CodingKey {
        case errorCode = "error_code"
        case message
    }
}

// MARK: Encode/decode helpers

class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
