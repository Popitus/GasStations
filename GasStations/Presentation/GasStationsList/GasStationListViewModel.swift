import Foundation
import Combine

class GasStationListViewModel: ObservableObject {
    private let getGasStations: GetGasStationsType
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var elements: [DomainGasStation] = []
    
    init(getGasStations: GetGasStationsType = GetGasStations()) {
        self.getGasStations = getGasStations
    }
    
    func getGasStations(idProvince: String, idProduct: String) {
        self.getGasStations.execute(idProvince: idProvince, idProduct: idProduct)
            .sink { completionResult in
                switch completionResult {
                    case let .failure(error):
                        print("Error getting GasStations list: \(error)")
                    case .finished:
                        print("FINISHED getting GasStations list!")
                }
            } receiveValue: { [weak self] allRetreivedGasStations in
                guard let self = self else { return }
                self.elements = allRetreivedGasStations.sorted()
            }
            .store(in: &cancellables)
    }
}
