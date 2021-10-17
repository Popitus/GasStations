import Foundation
import CoreLocation

struct GasStation: Decodable {
    let address: String
    let place: String
    let timetable: String
    let price: Double
    
    
    enum CodingKeys: String, CodingKey {
        case address = "Dirección"
        case timetable = "Horario"

        case price = "PrecioProducto"
        case place = "Localidad"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        address = try values.decode(String.self, forKey: .address)
        place = try values.decode(String.self, forKey: .place)
        timetable = try values.decode(String.self, forKey: .timetable)
        
        let priceString = try values.decode(String.self, forKey: .price).replacingOccurrences(of: ",", with: ".")
        price = Double(priceString)!
        
    }
}

extension GasStation {
    init(cdGasStations: CDGasStation) {
        self.address = cdGasStations.address ?? "No Address"
        self.place = cdGasStations.place ?? "No Address"
        self.timetable = cdGasStations.timetable ?? "No timetable"
        self.price = cdGasStations.price
    }
}

extension GasStation: Identifiable {
    var id: String {
        return address
    }
}
