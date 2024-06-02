import Foundation
import Model
import Networking

public struct TodoFetchAllRequest: Request {
    public init() {}
}

public struct TodoFetchAllResponse: Response {
    public let todos: [Todo]
    
    public init(todos: [Todo]) {
        self.todos = todos
    }
}

public struct TodoAddRequest: Request {
    public let task: String
    
    public init(task: String) {
        self.task = task
    }
}

public struct TodoAddResponse: Response {
    public let todo: Todo
    
    public init(todo: Todo) {
        self.todo = todo
    }
}

public struct TodoUpdateRequest: Request {
    public let todo: Todo
    
    public init(todo: Todo) {
        self.todo = todo
    }
}

public struct TodoUpdateResponse: Response {
    public let todo: Todo
    
    public init(todo: Todo) {
        self.todo = todo
    }
}

public struct TodoDeleteRequest: Request {
    public let id: String
    
    public init(id: String) {
        self.id = id
    }
}

public struct TodoDeleteResponse: EmptyResponse {
    public init() {}
}
