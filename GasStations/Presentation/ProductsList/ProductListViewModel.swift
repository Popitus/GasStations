import Combine

class ProductListViewModel: ObservableObject {
    private let getProductsUseCase: GetProductsUseCaseType
    
    @Published var elements: [DomainProduct] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init(getProductsUseCase: GetProductsUseCaseType = GetProductsUseCase()) {
        self.getProductsUseCase = getProductsUseCase
    }
    
    func getProducts() {
        self.getProductsUseCase.execute()
            .sink { completionResult in
                switch completionResult {
                case let .failure(error):
                    print("Error getting Products list: \(error)")
                case .finished:
                    print("FINISHED getting Products list!")
                }
            } receiveValue: { [weak self] allRetrievedProducts in
                self?.elements = allRetrievedProducts
            }
            .store(in: &cancellables)
    }
}
