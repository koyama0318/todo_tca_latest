import ComposableArchitecture
import Foundation
import Model
import Networking
import Data

public struct TodoClient {
    public var fetchAll: () async throws -> [Todo]
    public var add: (_ todo: Todo) async throws -> Void
    public var edit: (_ id: String, _ todo: Todo) async throws -> Void
    public var remove: (_ id: String) async throws -> Void
}

extension TodoClient: DependencyKey {
  public static let liveValue = Self(
    fetchAll: {
        let request = TodoFetchAllRequest()
        let result: Result<TodoFetchAllResponse, NetworkError> = await sendRequest(method: .get, body: request)
        
        switch result {
        case .success(let res):
            return res.todos
            
        case .failure(let error):
            print("Error: \(error.localizedDescription)")
            throw error
        }
    },
    add: { todo in
        let request = TodoAddRequest(todo: todo)
        let result: Result<TodoAddResponse, NetworkError> = await sendRequest(method: .post, body: request)

        switch result {
        case .success:
            return
            
        case .failure(let error):
            print("Error: \(error.localizedDescription)")
            throw error
        }
    },
    edit: { id, todo in
        let request = TodoEditRequest(id: id, todo: todo)
        let result: Result<TodoEditResponse, NetworkError> = await sendRequest(method: .put, body: request)

        switch result {
        case .success:
            return
            
        case .failure(let error):
            print("Error: \(error.localizedDescription)")
            throw error
        }
    },
    remove: { id in
        let request = TodoRemoveRequest(id: id)
        let result: Result<TodoEditResponse, NetworkError> = await sendRequest(method: .delete, body: request)

        switch result {
        case .success:
            return
            
        case .failure(let error):
            print("Error: \(error.localizedDescription)")
            throw error
        }
    }
  )
}


extension DependencyValues {
  public var todoClient: TodoClient {
    get { self[TodoClient.self] }
    set { self[TodoClient.self] = newValue }
  }
}
