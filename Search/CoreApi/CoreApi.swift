import Foundation
import Alamofire

@objc protocol CoreApiDelegate {
    @objc func finish(interFace : CoreApi, responseHeaders : HTTPURLResponse, data : Data)
    @objc optional func failed(interFace : CoreApi, result : AnyObject)
}

class CoreApi : NSObject {
    var URL = ""
    var encoding: ParameterEncoding = URLEncoding.default
    var delegate : CoreApiDelegate?
    var method : HTTPMethod = .get
    var isAuthorization = true
    
    static let sharedInstance = CoreApi()
    
    
    func getRequest(){
        Alamofire.request(URL, method: method, parameters : getParam(), encoding: encoding).responseJSON { response in
            print(response.request ?? "")  // original URL request
            print(response.result.value ?? "") // HTTP URL response
            if self.isConnectedToInternet() {
                let statusCode = response.response?.statusCode
                switch (statusCode) {
                    
                case 200,201:
                    
                    guard let responseHeader = response.response else { return }
                    guard let data = response.data else { return }
                    self.success(responseHeaders: responseHeader, data: data)
                    
                default:
                    self.failed(data: response.result.value as AnyObject)
                    
                }
            } else {
               // Handle if lose connection
            }
        }
        
    }
    
    func getParam() -> [String : Any]  {
        return [:]
    }
    
    func getHeader() -> HTTPHeaders {
        
        let headers = [
            "Content-type" :"application/json"
        ]

        return headers
    }
    
    
    func success(responseHeaders : HTTPURLResponse, data : Data) {
        delegate?.finish(interFace: self, responseHeaders : responseHeaders, data : data)
    }
    
    func failed(data : AnyObject) {
        delegate?.failed!(interFace: self, result: data)
    }
    
    func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }

}
