import Foundation

enum CatsAPI: API {
    case facts
    case foto
    
    var scheme: HTTPScheme {
        switch self {
        case .facts, .foto:
            return .https
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .facts, .foto:
            return .get
        }
    }
    
    var baseURL: String {
        switch self {
        case .facts:
            return "cat-fact.herokuapp.com"
        case .foto:
            return "api.thecatapi.com"
        }
    }
    
    var path: String {
        switch self {
        case .facts:
            return "/facts"
        case .foto:
            return "/v1/images/search"
        }
    }
    
    
}


