import Foundation
import Combine
import CoreLocation

class CCAAListViewModel: ObservableObject {
    private let getCCAAUseCase: GetCCAAUseCaseType
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var elements: [DomainCCAA] = []
    
    init(getCCAAUseCase: GetCCAAUseCaseType = GetCCAAUseCase()) {
        self.getCCAAUseCase = getCCAAUseCase
    }
    
    func getCCAAs() {
        self.getCCAAUseCase.execute()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { complete in
                switch complete {
                case let .failure(error):
                    print("F: \(error)")
                case .finished:
                    print("FINISHED")
                }
            }) { allCCAAs in
                self.elements = allCCAAs
            }
            .store(in: &cancellables)
    }
}
