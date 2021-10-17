import Foundation
import Combine

protocol GasStationsAPIClientType {
    func getProducts() -> AnyPublisher<[Product], Error>
    func getCCAA() -> AnyPublisher<[CCAA], Error>
    func getProvinces(idCCAA: String?) -> AnyPublisher<[Province], Error>    
    func getGasStations(idCCAA: String, idProduct: String) -> AnyPublisher<GasPrices, Error>
    func getGasStations(idProvince: String, idProduct: String) -> AnyPublisher<GasPrices, Error>
    func getGasStations(idMunicipality: String, idProduct: String) -> AnyPublisher<GasPrices, Error>
}

final class GasStationsAPIClient: BaseAPIClient {
    let session: URLSession
    let jsonDecoder: JSONDecoder
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
        self.jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
}

extension GasStationsAPIClient: GasStationsAPIClientType {
    func getProducts() -> AnyPublisher<[Product], Error> {
        execute(GasStationLocationEndpoint.getProducts)
    }
    
    func getCCAA() -> AnyPublisher<[CCAA], Error> {
        execute(GasStationLocationEndpoint.getCCAA)
    }
    
    func getProvinces(idCCAA: String?) -> AnyPublisher<[Province], Error> {
        execute(GasStationLocationEndpoint.getProvinces(idCCAA: idCCAA))
    }
    
    func getGasStations(idCCAA: String, idProduct: String) -> AnyPublisher<GasPrices, Error> {
        execute(GasStationLocationEndpoint.getGasStations(idCCAA: idCCAA, idProduct: idProduct))
    }
    
    func getGasStations(idProvince: String, idProduct: String) -> AnyPublisher<GasPrices, Error> {
        execute(GasStationLocationEndpoint.getGasStations(idProvince: idProvince, idProduct: idProduct))
    }
    
    func getGasStations(idMunicipality: String, idProduct: String) -> AnyPublisher<GasPrices, Error> {
        execute(GasStationLocationEndpoint.getGasStations(idMunicipality: idMunicipality, idProduct: idProduct))
    }
}
