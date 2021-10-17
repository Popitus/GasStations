import Foundation

///
/// https://sedeaplicaciones.minetur.gob.es/ServiciosRESTCarburantes/PreciosCarburantes/help
///

enum GasStationLocationEndpoint {
    case getProducts
    case getCCAA
    case getProvinces(idCCAA: String?)
    case getMunicipalities(idProvince: String?)
    case getGasStations(idCCAA: String? = nil,
                        idProvince: String? = nil,
                        idMunicipality: String? = nil,
                        idProduct: String? = nil)
}

extension GasStationLocationEndpoint: Endpoint {
    var base: String {
        return "https://sedeaplicaciones.minetur.gob.es/ServiciosRESTCarburantes/PreciosCarburantes"
    }
    
    var method: HTTPMethod {
        return .GET
    }
    
    var parameters: [String: String]? {
        return nil
    }
    
    var path: String {
        switch self {
        case .getProducts:
            return "/Listados/ProductosPetroliferos/"
        case .getCCAA:
            return "/Listados/ComunidadesAutonomas"
        case let .getProvinces(idCCAA):
            if let idCCAA = idCCAA {
                return "/Listados/ProvinciasPorComunidad/\(idCCAA)"
            } else {
                return "/Listados/Provincias/"
            }
        case let .getMunicipalities(idProvince):
            if let idProvince = idProvince {
                return "/Listados/MunicipiosPorProvincia/\(idProvince)"
            } else {
                return "/Listados/Municipios/"
            }
            
            
        case let .getGasStations(idCCAA, idProvince, idMunicipality, idProduct):
            switch (idCCAA, idProvince, idMunicipality, idProduct) {
                
                // Filter by CCAA
            case let (.some(unwrappedIdCCAA), .none, .none, .none):
                return "/EstacionesTerrestres/FiltroCCAA/\(unwrappedIdCCAA)"
            
                // Filter by CCAA + Product
            case let (.some(unwrappedIdCCAA), .none, .none, .some(unwrappedProduct)):
                return "/EstacionesTerrestres/FiltroCCAAProducto/\(unwrappedIdCCAA)/\(unwrappedProduct)"
            
                // Filter by PROVINCE
            case let (.none, .some(unwrappedIdProvince), .none, .none):
                return "/EstacionesTerrestres/FiltroProvincia/\(unwrappedIdProvince)"
            
                // Filter by PROVINCE + Product
            case let (.none, .some(unwrappedIdProvince), .none, .some(unwrappedProduct)):
                return "/EstacionesTerrestres/FiltroProvinciaProducto/\(unwrappedIdProvince)/\(unwrappedProduct)"
                
                // Filter by MUNICIPALITY
            case let (.none, .none, .some(unwrappedIdMunicipality), .none):
                return "/EstacionesTerrestres/FiltroMunicipio/\(unwrappedIdMunicipality)"
            
                // Filter by MUNICIPALITY + Product
            case let (.none, .none, .some(unwrappedIdMunicipality), .some(unwrappedProduct)):
                return "/EstacionesTerrestres/FiltroMunicipioProducto/\(unwrappedIdMunicipality)/\(unwrappedProduct)"
            default:
                fatalError("You MUST choose either idCCAA, idProvince or idMunicipality")
            }
        }
    }
}
