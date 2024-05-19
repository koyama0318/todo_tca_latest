import Foundation

public struct Todo: Equatable {
    public init(id: String, text: String) {
        self.id = id
        self.text = text
    }
    
    public let id: String
    public let text: String
}
