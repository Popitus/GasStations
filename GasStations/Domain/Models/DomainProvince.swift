import Foundation

struct DomainProvince: Identifiable {
    let id: String
    let name: String
}

extension DomainProvince {
    init(province: Province) {
        self.id = province.idProvince
        self.name = province.provinceName
    }
}

extension DomainProvince: Hashable {
    static func == (lhs: DomainProvince, rhs: DomainProvince) -> Bool {
        return lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}

