import Foundation

class NetworkingManager {
    private func buildURL (endpoint: API) -> URLComponents {
        
        var components = URLComponents()
        components.scheme = endpoint.scheme.rawValue
        components.host = endpoint.baseURL
        components.path = endpoint.path
        return components
        
    }
    
    func request<T: Decodable>(endpoint: API, completion: @escaping (Result<T, NetworkingError>) -> Void) {
        
        let components = buildURL(endpoint: endpoint)
        
        guard let url = components.url else {
            completion(.failure(.ivalidURL))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method.rawValue
        
        let session = URLSession(configuration: .default)
        
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            if error != nil {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let object = try JSONDecoder().decode(T.self, from: data)
                completion(.success(object))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        dataTask.resume()
    }
}
