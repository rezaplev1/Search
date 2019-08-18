import Foundation
class SearchApi : CoreApi {
    var page = 0
    
    override init () {
        super.init()
        self.URL = server(with: ConstantsApi.SEARCH_API)
    }
    
    func start() {
        getRequest()
    }
    
    override func success(responseHeaders : HTTPURLResponse, data : Data) {
        delegate?.finish(interFace: self, responseHeaders : responseHeaders, data : data)
    }
    
    override func failed(data: AnyObject) {
        delegate?.failed!(interFace: self, result: data)
    }
    
    override func getParam() -> [String : Any] {
        let parameters: [String : Any] = [SearchConst.query : "indonesia", //hardcode base on task
                                          SearchConst.apiKey : "9b693ffaa5fe451090146e5c90fbed78",
                                          SearchConst.page : page
        ]
        return parameters
    }
    
}

struct SearchConst {
    static let query = "q"
    static let apiKey = "api-key"
    static let page = "page"
}

