import Foundation

struct ConstantsApi {
    static let BASE_URL = "https://ace.tokopedia.com/"
    static let SEARCH_API = "search/v2.5/product"
}

public func server(with api: String) -> String {
    let serverURL = "\(ConstantsApi.BASE_URL)\(api)"
    return serverURL
}
