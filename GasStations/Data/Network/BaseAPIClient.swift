import Foundation
import Combine

protocol BaseAPIClient {
    var session: URLSession { get }
    var jsonDecoder: JSONDecoder { get }
    
    func execute<T>(_ endpoint: Endpoint,
                    queue: DispatchQueue,
                    retries: Int) -> AnyPublisher<T, Error> where T: Decodable
}

extension BaseAPIClient {
    func execute<T>(_ endpoint: Endpoint,
                    queue: DispatchQueue = .main,
                    retries: Int = 0) -> AnyPublisher<T, Error> where T: Decodable {
        return session.dataTaskPublisher(for: endpoint.request)            
            .tryMap {
                guard let response = $0.response as? HTTPURLResponse, response.statusCode == 200 else {
                    print($0.response)
                    throw APIError.responseUnsuccessful
                }
                return $0.data
            }
            .decode(type: T.self, decoder: jsonDecoder)
            .receive(on: queue)
            .retry(retries)
            .eraseToAnyPublisher()
    }
}
