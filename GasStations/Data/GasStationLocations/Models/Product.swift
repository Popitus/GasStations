import Foundation

struct Product {
    let idProduct: String
    let productName: String
    let shortProductName: String
}

extension Product: Decodable {
    enum CodingKeys: String, CodingKey {
        case idProduct = "IDProducto"
        case productName = "NombreProducto"
        case shortProductName = "NombreProductoAbreviatura"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        idProduct = try values.decode(String.self, forKey: .idProduct)
        productName = try values.decode(String.self, forKey: .productName)
        shortProductName = try values.decode(String.self, forKey: .shortProductName)
    }
}

extension Product {
    init(cdProduct: CDProduct) {
        self.idProduct = cdProduct.idProduct ?? "NO idProduct"
        self.productName = cdProduct.productName ?? "NO ProductName"
        self.shortProductName = cdProduct.shortProductName ?? "NO shortProductName"
    }
}

extension Product: Identifiable {
    var id: String {
        return idProduct
    }
}
