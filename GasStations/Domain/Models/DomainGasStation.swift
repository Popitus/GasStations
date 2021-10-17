import Foundation
import CoreLocation

struct DomainGasStation {
    let address: String
    let place: String
    let timetable: String
    let price: Double
}

extension DomainGasStation: Identifiable {
    var id: String {
        return address
    }
}

extension DomainGasStation {
    init(gasStation: GasStation) {
        self.address = gasStation.address
        self.place = gasStation.place
        self.timetable = gasStation.timetable
        self.price = gasStation.price
    }
}

extension DomainGasStation: Comparable {
    static func < (lhs: DomainGasStation, rhs: DomainGasStation) -> Bool {
        return lhs.price < rhs.price
    }
    
    static func == (lhs: DomainGasStation, rhs: DomainGasStation) -> Bool {
        return lhs.price == rhs.price
    }
}
