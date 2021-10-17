import Foundation

struct GasPrices {
    let date: String
    let elements: [GasStation]
    
    static let empty = GasPrices(date: "", elements: [])
}

extension GasPrices: Decodable {
    enum CodingKeys: String, CodingKey {
        case date = "Fecha"
        case elements = "ListaEESSPrecio"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        date = try values.decode(String.self, forKey: .date)
        elements = try values.decode([GasStation].self, forKey: .elements)
    }
}

