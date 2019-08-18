import Foundation

struct ConstantsApi {
    static let BASE_URL = "https://api.nytimes.com/"
    static let SEARCH_API = "svc/search/v2/articlesearch.json"
}

public func server(with api: String) -> String {
    let serverURL = "\(ConstantsApi.BASE_URL)\(api)"
    return serverURL
}

