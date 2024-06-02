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
    public let task: String
    
    public init(task: String) {
        self.task = task
    }
}

public struct TodoAddResponse: Decodable {
    public let todo: Todo
    
    public init(todo: Todo) {
        self.todo = todo
    }
}

public struct TodoUpdateRequest: Encodable {
    public let todo: Todo
    
    public init(todo: Todo) {
        self.todo = todo
    }
}

public struct TodoUpdateResponse: Decodable {
    public let todo: Todo
    
    public init(todo: Todo) {
        self.todo = todo
    }
}

public struct TodoDeleteRequest: Encodable {
    public let id: String
    
    public init(id: String) {
        self.id = id
    }
}

public struct TodoDeleteResponse: Decodable {
    public let id: String
    
    public init(id: String) {
        self.id = id
    }
}
