import ComposableArchitecture
import Foundation
import Model
import Networking
import Data

public struct TodoClient {
    public var fetchAll: () async throws -> [Todo]
    public var add: (_ task: String) async throws -> Todo
    public var update: (_ todo: Todo) async throws -> Todo
    public var delete: (_ id: String) async throws -> Void
}

extension TodoClient: DependencyKey {
  public static let liveValue = Self(
    fetchAll: {
        let req = TodoFetchAllRequest()
        let result: Result<TodoFetchAllResponse, NetworkError> = await sendRequest(path: "todos/", method: .get, body: req)
        
        switch result {
        case .success(let res):
            return res.todos
            
        case .failure(let error):
            print("Error: \(error.localizedDescription)")
            throw error
        }
    },
    add: { task in
        let req = TodoAddRequest(task: task)
        let result: Result<TodoAddResponse, NetworkError> = await sendRequest(path: "todos/", method: .post, body: req)

        switch result {
        case .success(let res):
            return res.todo
            
        case .failure(let error):
            print("Error: \(error.localizedDescription)")
            throw error
        }
    },
    update: { todo in
        let req = TodoUpdateRequest(todo: todo)
        let result: Result<TodoUpdateResponse, NetworkError> = await sendRequest(path: "todos/\(todo.id)", method: .put, body: req)

        switch result {
        case .success:
            return req.todo
            
        case .failure(let error):
            print("Error: \(error.localizedDescription)")
            throw error
        }
    },
    delete: { id in
        let req = TodoDeleteRequest(id: id)
        let result: Result<TodoDeleteResponse, NetworkError> = await sendRequest(path: "todos/\(id)", method: .delete, body: req)

        switch result {
        case .success:
            return
            
        case .failure(let error):
            print("Error: \(error.localizedDescription)")
            throw error
        }
    }
  )
    
    public static let testValue = Self(
        fetchAll: { return [] },
        add: { _ in Todo(id: "1", task: "todo1", completed: false) },
        update: { _ in Todo(id: "1", task: "todo1", completed: true) },
        delete: { _ in }
    )
}


extension DependencyValues {
  public var todoClient: TodoClient {
    get { self[TodoClient.self] }
    set { self[TodoClient.self] = newValue }
  }
}
