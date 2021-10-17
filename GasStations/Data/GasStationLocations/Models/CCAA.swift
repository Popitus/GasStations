import Foundation

struct CCAA {
    let idCCAA: String
    let ccaaName: String
}

extension CCAA: Decodable {
    enum CodingKeys: String, CodingKey {
        case idCCAA = "IDCCAA"
        case ccaaName = "CCAA"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        idCCAA = try values.decode(String.self, forKey: .idCCAA)
        ccaaName = try values.decode(String.self, forKey: .ccaaName)
    }
}

extension CCAA {
    init(cdCCAA: CDCCAA) {
        self.idCCAA = cdCCAA.idCCAA ?? "NO idCCAA"
        self.ccaaName = cdCCAA.ccaaName ?? "NO ccaaName"
    }
}

extension CCAA: Identifiable {
    var id: String {
        return ccaaName
    }
}
