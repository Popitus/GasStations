import Foundation

struct DomainCCAA: Identifiable {
    var id: String
    let name: String
    let provinces: [DomainProvince]
}

extension DomainCCAA {
    init(ccaa: CCAA, dataProvinces: [Province]) {
        self.id = ccaa.idCCAA
        self.name = ccaa.ccaaName
        self.provinces = dataProvinces.map { DomainProvince(province: $0) }
    }
}

extension DomainCCAA: Hashable {
    static func == (lhs: DomainCCAA, rhs: DomainCCAA) -> Bool {
        return lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
