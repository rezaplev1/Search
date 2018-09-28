import Foundation
class SearchApi : CoreApi {
    var priceMin = ""
    var priceMax = ""
    var wholesale = false
    var official = false
    var fshop = "2"
    var skip = "0"
    var rows = "10"
    
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
        let parameters: [String : Any] = [SearchConst.query : "samsung", //hardcode base on task
                                          SearchConst.priceMin : priceMin,
                                          SearchConst.pricMax : priceMax,
                                          SearchConst.wholesale : wholesale,
                                          SearchConst.official : official,
                                          SearchConst.fshop : fshop,
                                          SearchConst.start : skip,
                                          SearchConst.rows : rows
        ]
        return parameters
    }
    
}

struct SearchConst {
    static let query = "q"
    static let priceMin = "pmin"
    static let pricMax = "pmax"
    static let wholesale = "wholesale"
    static let official = "official"
    static let fshop = "fshop"
    static let start = "start"
    static let rows = "rows"
}

