import Foundation

struct DomainProduct: Identifiable {
    let id: String
    let name: String
    let shortName: String
}

extension DomainProduct {
    init(product: Product) {
        self.id = product.idProduct
        self.name = product.productName
        self.shortName = product.shortProductName
    }
}

extension DomainProduct: Hashable {
    static func == (lhs: DomainProduct, rhs: DomainProduct) -> Bool {
        return lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
