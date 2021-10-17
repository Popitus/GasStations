import Foundation
import Combine

protocol GetProvincesUseCaseType {
    func execute(idCCAA: String?) -> AnyPublisher<[DomainProvince], Error>
}

struct GetProvincesUseCase: GetProvincesUseCaseType {
    private let gasStationsRepository: GasStationsRepositoryType
    
    init(gasStationsRepository: GasStationsRepositoryType = GasStationsRepository()) {
        self.gasStationsRepository = gasStationsRepository
    }
    
    func execute(idCCAA: String?) -> AnyPublisher<[DomainProvince], Error> {
        var idStr = ""
        if let idCCAA = idCCAA {
            idStr = " with idCCAA: \(idCCAA)"
        }
        
        print("GetProvincesUseCase going to retrieve provinces" + idStr)
        return gasStationsRepository.getProvinces(idCCAA: idCCAA)
    }
}
