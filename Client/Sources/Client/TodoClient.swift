import ComposableArchitecture
import Foundation
import Model

public struct TodoClient {
    public var fetchAll: () async throws -> [Todo]
}

extension TodoClient: DependencyKey {
  public static let liveValue = Self(
    fetchAll: {
        return [
            Todo(id: UUID().uuidString, text: "todo1"),
            Todo(id: UUID().uuidString, text: "todo2"),
            Todo(id: UUID().uuidString, text: "todo3"),
            Todo(id: UUID().uuidString, text: "todo4"),
            Todo(id: UUID().uuidString, text: "todo5"),
        ]
    }
  )
}


extension DependencyValues {
  public var todoClient: TodoClient {
    get { self[TodoClient.self] }
    set { self[TodoClient.self] = newValue }
  }
}
