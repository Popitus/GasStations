import Combine

protocol GetProductsUseCaseType {
    func execute() -> AnyPublisher<[DomainProduct], Error>
}

struct GetProductsUseCase: GetProductsUseCaseType {
    private let gasStationsRepository: GasStationsRepositoryType
    
    init(gasStationsRepository: GasStationsRepositoryType = GasStationsRepository()) {
        self.gasStationsRepository = gasStationsRepository
    }
    
    func execute() -> AnyPublisher<[DomainProduct], Error> {
        gasStationsRepository.getProducts()        
    }
}
