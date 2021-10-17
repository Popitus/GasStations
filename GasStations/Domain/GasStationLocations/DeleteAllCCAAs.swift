import Combine

protocol DeleteAllCCAAsType {
    func execute() -> AnyPublisher<Int, Error>
}

struct DeleteAllCCAAs: DeleteAllCCAAsType {
    private let gasStationsRepository: GasStationsRepositoryType
    
    init(gasStationsRepository: GasStationsRepositoryType = GasStationsRepository()) {
        self.gasStationsRepository = gasStationsRepository
    }
    
    func execute() -> AnyPublisher<Int, Error> {
        gasStationsRepository.deleteAllCCAAs()
    }
}
