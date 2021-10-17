import Foundation
import Combine

protocol GasStationsRepositoryType {
    func getCCAA() -> AnyPublisher<[DomainCCAA], Error>
    func deleteAllCCAAs() -> AnyPublisher<Int, Error>
    
    func getProvinces(idCCAA: String?) -> AnyPublisher<[DomainProvince], Error>
    func deleteAllProvinces() -> AnyPublisher<Int, Error>
    
    func getProducts() -> AnyPublisher<[DomainProduct], Error>
    
    func getGasStations(idProvince: String,
                        idProduct: String) -> AnyPublisher<[DomainGasStation], Error>
    
    func getGasStations(idCCAA: String,
                        idProduct: String) -> AnyPublisher<[DomainGasStation], Error>
}

struct GasStationsRepository {
    private let localDataSource: GasStationsLocalDataSourceType
    private let apiClient: GasStationsAPIClientType
    
    init(localDataSource: GasStationsLocalDataSourceType = GasStationsLocalDataSource(),
         apiClient: GasStationsAPIClientType = GasStationsAPIClient()) {
        self.localDataSource = localDataSource
        self.apiClient = apiClient
    }
}


extension GasStationsRepository: GasStationsRepositoryType {
    func getSimulatenous() -> AnyPublisher<[DomainCCAA], Error>  {
        let localCCAAs = localDataSource.getCCAA()
        let apiCCAAs = apiClient.getCCAA()
        
        let result = Publishers.Merge(localCCAAs, apiCCAAs)
            .compactMap { $0.map { DomainCCAA(ccaa: $0, dataProvinces: []) } }
            .eraseToAnyPublisher()
        
        return result
    }
    
    func getCCAA() -> AnyPublisher<[DomainCCAA], Error> {
        let retrievedCCAAs = localDataSource.getCCAA()
        
        let checkedCCAAs = retrievedCCAAs
            .flatMap { allCCAAsArray -> AnyPublisher<[CCAA], Error> in
                print("GasStationsRepository we got \(allCCAAsArray.count) CCAAs from the local data source")
                // timestamp
                if allCCAAsArray.isEmpty {
                    print("GasStationsRepository going to fetch all CCAAs from the API")
                    return apiClient.getCCAA()
                        .flatMap {
                            return localDataSource.save(ccaaList: $0)
                        }
                        .eraseToAnyPublisher()
                } else {
                    return Future<[CCAA], Error>() { promise in
                        promise(.success(allCCAAsArray))
                    }
                    .eraseToAnyPublisher()
                }
            }
        
        let result = checkedCCAAs.compactMap { $0.map { DomainCCAA(ccaa: $0, dataProvinces: []) } }
            .eraseToAnyPublisher()
        
        return result
    }
    
    func deleteAllProvinces() -> AnyPublisher<Int, Error> {
        localDataSource.deleteAllProvinces()
    }
    
    func getProvinces(idCCAA: String?) -> AnyPublisher<[DomainProvince], Error> {
        let retrievedProvinces = localDataSource.getProvinces(idCCAA: idCCAA)
        
        let checkedProvinces = retrievedProvinces
            .flatMap { allProvincesArray -> AnyPublisher<[Province], Error> in
                print("GasStationsRepository we got \(allProvincesArray.count) provinces from the local data source")
                // timestamp
                if allProvincesArray.isEmpty {
                    print("GasStationsRepository going to fetch provinces from the API")
                    return apiClient.getProvinces(idCCAA: idCCAA)
                        .flatMap {
                            return localDataSource.save(provincesList: $0)
                        }
                        .eraseToAnyPublisher()
                } else {
                    return Future<[Province], Error>() { promise in
                        promise(.success(allProvincesArray))
                    }
                    .eraseToAnyPublisher()
                }
            }
        
        
        let result = checkedProvinces.compactMap { $0.map { DomainProvince(province: $0) } }
            .eraseToAnyPublisher()
        
        return result
    }
    
    func deleteAllCCAAs() -> AnyPublisher<Int, Error> {
        localDataSource.deleteAllCCAAs()
    }
    
    func getProducts() -> AnyPublisher<[DomainProduct], Error> {
        let retrieveProducts = localDataSource.getProducts()
        
        let checkedProducts = retrieveProducts
            .flatMap { allProductsArray -> AnyPublisher<[Product], Error> in
                print("GasStationsRepository we got \(allProductsArray.count) Products from the local data source")
                
                //timestamp
                if allProductsArray.isEmpty {
                    print("GasStationsRepository going to fetch all Products from the API")
                    return apiClient.getProducts()
                        .flatMap{
                            return localDataSource.save(productList: $0)
                        }
                        .eraseToAnyPublisher()
                } else {
                    return Future<[Product], Error>() { promise in
                        promise(.success(allProductsArray))
                    }
                    .eraseToAnyPublisher()
                }
            }
        let result = checkedProducts.compactMap { $0.map { DomainProduct(product: $0) } }
            .eraseToAnyPublisher()
        return result
    }
    
    func getGasStations(idProvince: String,
                        idProduct: String) -> AnyPublisher<[DomainGasStation], Error> {
                let retrieveGasStations = localDataSource.getGasStations(idProvince: idProvince, idProduct: idProduct)
                let checkedGasStations = retrieveGasStations
                    .flatMap { allGasStationsArray -> AnyPublisher<[GasStation], Error> in
                        print("GasStationsRepository we got \(allGasStationsArray.count) GasStations from the local data source")
                        // timestamp
                        if allGasStationsArray.isEmpty {
                            print("GasStationsRepository going to fetch GasStations from the API")
                            return apiClient.getGasStations(idProvince: idProvince, idProduct: idProduct)
                                .flatMap { gasPrices in
                                    return localDataSource.save(gasStationsList: gasPrices, idProvince: idProvince, idProduct: idProduct)
                                }
                                .eraseToAnyPublisher()
                        } else {
                            return Future<[GasStation], Error>() { promise in
                                promise(.success(allGasStationsArray))
                            }
                            .eraseToAnyPublisher()
                        }
                    }
                let result = checkedGasStations.compactMap { $0.map { DomainGasStation(gasStation: $0) }}
                    .eraseToAnyPublisher()
                return result
    }
    
    func getGasStations(idCCAA: String,
                        idProduct: String) -> AnyPublisher<[DomainGasStation], Error> {
        apiClient.getGasStations(idCCAA: idCCAA, idProduct: idProduct)
            .compactMap { gasPrices in
                return gasPrices.elements.map { currentGasStation in
                    return DomainGasStation(gasStation: currentGasStation)
                }
            }
            .eraseToAnyPublisher()
    }
}
