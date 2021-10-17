import Foundation

struct Province {
    let idProvince: String
    let idCCAA: String
    let provinceName: String
    let ccaaName: String
}

extension Province: Decodable {
    enum CodingKeys: String, CodingKey {
        case idProvince = "IDPovincia"
        case idCCAA = "IDCCAA"
        case provinceName = "Provincia"
        case ccaaName = "CCAA"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        idProvince = try values.decode(String.self, forKey: .idProvince)
        idCCAA = try values.decode(String.self, forKey: .idCCAA)
        provinceName = try values.decode(String.self, forKey: .provinceName)
        ccaaName = try values.decode(String.self, forKey: .ccaaName)
    }
}

extension Province {
    init(cdProvince: CDProvince) {
        self.idProvince = cdProvince.idProvince ?? "NO idProvince"
        self.provinceName = cdProvince.provinceName ?? "NO provinceName"
        self.idCCAA = cdProvince.belongs?.idCCAA ?? "NO idCCAA"
        self.ccaaName = cdProvince.belongs?.ccaaName ?? "NO ccaaName"
    }
}

extension Province: Identifiable {
    var id: String {
        return provinceName
    }
}
