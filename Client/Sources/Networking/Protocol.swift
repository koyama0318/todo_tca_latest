import Foundation

public protocol Request: Encodable {}

public protocol Response: Decodable {}

public protocol EmptyResponse: Response {
    init()
}
