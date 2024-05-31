import Foundation

public struct Todo: Equatable, Codable {
    public let id: String
    public let task: String
    public let completed: Bool
    
    public init(id: String, task: String, completed: Bool) {
        self.id = id
        self.task = task
        self.completed = completed
    }
}
