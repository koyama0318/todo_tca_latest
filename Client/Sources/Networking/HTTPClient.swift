import Foundation
import Data
import Model

public enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case decodingError
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

public func sendRequest<T: Decodable, U: Encodable>(
    baseURL: String = "http://127.0.0.1:8080/",
    path: String = "",
    method: HTTPMethod,
    body: U? = nil
) async -> Result<T, NetworkError> {
    guard let url = URL(string: baseURL + path) else {
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
    
    log(req: request, res: data)
    
    guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
        return .failure(NetworkError.requestFailed)
    }
    
    guard let decoded = try? JSONDecoder().decode(T.self, from: data) else {
        return .failure(NetworkError.decodingError)
    }
    
    return .success(decoded)
}

private func log(req: URLRequest, res: Data) {
    print(req)
    print("mothod: \(req.httpMethod ?? "")")
    print("body: \(String(data: req.httpBody ?? Data(), encoding: .utf8) ?? "")")
    print("\(String(data: res, encoding: .utf8) ?? "")\n")
}
