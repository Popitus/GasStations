import Combine

protocol GetGasStationsType {
    func execute(idProvince: String, idProduct: String) -> AnyPublisher<[DomainGasStation], Error>
    func execute(idCCAA: String, idProduct: String) -> AnyPublisher<[DomainGasStation], Error>
}

struct GetGasStations: GetGasStationsType {
    private let gasStationsRepository: GasStationsRepositoryType
    
    init(gasStationsRepository: GasStationsRepositoryType = GasStationsRepository()) {
        self.gasStationsRepository = gasStationsRepository
    }
    
    func execute(idProvince: String, idProduct: String) -> AnyPublisher<[DomainGasStation], Error> {
        gasStationsRepository.getGasStations(idProvince: idProvince, idProduct: idProduct)
    }
    
    func execute(idCCAA: String, idProduct: String) -> AnyPublisher<[DomainGasStation], Error> {
        gasStationsRepository.getGasStations(idCCAA: idCCAA, idProduct: idProduct)
    }
}
