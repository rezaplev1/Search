
import Foundation

// MARK: - TimeNews
struct TimeNews: Codable {
    let status, copyright: String?
    let response: Response?
}

// MARK: - Response
struct Response: Codable {
    let docs: [Doc]?
    let meta: Meta?
}

// MARK: - Doc
struct Doc: Codable {
    let webURL: String?
    let snippet: String?
    let multimedia: [Multimedia]?
    let headline: Headline?
    
    func getImageUri() -> String {
        if let image = multimedia?.first, (image.url != nil) {
            return "\(ConstantsApi.BASE_URL)\(image.url!)"
        }else{
           return ""
        }
       
    }
    
    enum CodingKeys: String, CodingKey {
        case webURL = "web_url"
        case snippet
        case multimedia
        case headline
    }
}

// MARK: - Blog
struct Blog: Codable {
}

// MARK: - Byline
struct Byline: Codable {
    let original: String?
    let person: [Person]?
    let organization: String?
}

// MARK: - Person
struct Person: Codable {
    let firstname: String?
    let middlename: String?
    let lastname: String?
    let qualifier, title: JSONNull?
    let role: Role?
    let organization: String?
    let rank: Int?
}

enum Role: String, Codable {
    case reported = "reported"
}

enum DocumentType: String, Codable {
    case article = "article"
    case paidpost = "paidpost"
}

// MARK: - Headline
struct Headline: Codable {
    let main: String?
    let kicker: String?
    let contentKicker: JSONNull?
    let printHeadline: String?
    let name, seo, sub: JSONNull?
    
    
    
    enum CodingKeys: String, CodingKey {
        case main, kicker
        case contentKicker = "content_kicker"
        case printHeadline = "print_headline"
        case name, seo, sub
    }
}

// MARK: - Keyword
struct Keyword: Codable {
    let name: Name?
    let value: String?
    let rank: Int?
    let major: Major?
}

enum Major: String, Codable {
    case n = "N"
}

enum Name: String, Codable {
    case glocations = "glocations"
    case organizations = "organizations"
    case persons = "persons"
    case subject = "subject"
}

// MARK: - Multimedia
struct Multimedia: Codable {
    let rank: Int?
    let subtype: String?
    let caption, credit: JSONNull?
    let type: TypeEnum?
    let url: String?
    let height, width: Int?
    let legacy: Legacy?
    let subType, cropName: String?
    
    enum CodingKeys: String, CodingKey {
        case rank, subtype, caption, credit, type, url, height, width, legacy, subType
        case cropName = "crop_name"
    }
}

// MARK: - Legacy
struct Legacy: Codable {
    let xlarge: String?
    let xlargewidth, xlargeheight: Int?
    let thumbnail: String?
    let thumbnailwidth, thumbnailheight, widewidth, wideheight: Int?
    let wide: String?
}

enum TypeEnum: String, Codable {
    case image = "image"
}

// MARK: - Meta
struct Meta: Codable {
    let hits, offset, time: Int?
}

// MARK: - Encode/decode helpers

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
