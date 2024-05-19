import ComposableArchitecture
import Model

public struct TodoClient {
    let fetch: () async throws -> [Todo]
}

extension TodoClient: DependencyKey {
  public static let liveValue = Self(
    fetch: { return [] }
  )
}


extension DependencyValues {
  public var todoClient: TodoClient {
    get { self[TodoClient.self] }
    set { self[TodoClient.self] = newValue }
  }
}
