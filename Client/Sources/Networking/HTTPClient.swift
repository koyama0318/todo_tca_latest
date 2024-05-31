import Foundation
import Data
import Model

public enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case invalidResponse
    case decodingError
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

public func sendRequest<T: Decodable, U: Encodable>(
    urlString: String = "http://127.0.0.1:8001/",
    method: HTTPMethod,
    body: U? = nil
) async -> Result<T, NetworkError> {
    guard let url = URL(string: urlString) else {
        return .failure(NetworkError.invalidURL)
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = method.rawValue
    
    if let body, method != .get {
        request.httpBody = try? JSONEncoder().encode(body)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    }
    
    guard let (data, response) = try? await URLSession.shared.data(for: request) else {
        return .failure(NetworkError.requestFailed)
    }
    
    guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
        return .failure(NetworkError.invalidResponse)
    }
    
    guard let decoded = try? JSONDecoder().decode(T.self, from: data) else {
        return .failure(NetworkError.decodingError)
    }
    
    return .success(decoded)
}
