import Foundation
import Model

public struct TodoFetchAllRequest: Encodable {
    public init() {}
}

public struct TodoFetchAllResponse: Decodable {
    public let todos: [Todo]
    
    public init(todos: [Todo]) {
        self.todos = todos
    }
}

public struct TodoAddRequest: Encodable {
    public let todo: Todo
    
    public init(todo: Todo) {
        self.todo = todo
    }
}

public struct TodoAddResponse: Decodable {
    public init() {}
}

public struct TodoEditRequest: Encodable {
    public let id: String
    public let todo: Todo
    
    public init(id: String, todo: Todo) {
        self.id = id
        self.todo = todo
    }
}

public struct TodoEditResponse: Decodable {
    public init() {}
}

public struct TodoRemoveRequest: Encodable {
    public let id: String
    
    public init(id: String) {
        self.id = id
    }
}

public struct TodoRemoveResponse: Decodable {
    public init() {}
}
