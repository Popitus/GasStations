import Foundation

enum HTTPMethod: String {
    case GET
    case PUT
    case UPDATE
    case DELETE
}

protocol Endpoint {
    var base: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: String]? { get }
    var headers: [String: String]? { get }
}

extension Endpoint {
    var headers: [String: String]? {
        return nil
    }
}

extension Endpoint {
    var urlComponents: URLComponents {
        let url = URL(string: base)!.appendingPathComponent(path)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        components.queryItems = parameters?.compactMap {
            URLQueryItem(name: $0.key, value: $0.value)
        }
        
        return components
    }
    
    var request: URLRequest {
        let url = urlComponents.url!
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let head = headers {
            request.allHTTPHeaderFields = head
        } else {
            request.allHTTPHeaderFields = ["Accept": "application/json"]
        }
        
        return request
    }
}
