import XCTest
import ComposableArchitecture
import Model

@testable import TodoList

final class TodoListFeatureTests: XCTestCase {
    private let todo = Todo(id: UUID().uuidString, text: "text")
    
    @MainActor
    func testViewAppearedOnSuccess() async {
        let store = TestStore(initialState: TodoListFeature.State()) {
            TodoListFeature()
        } withDependencies: {
            $0.todoClient.fetchAll = {
                [Todo(id: "1", text: "todo1")]
            }
        }
        await store.send(\.viewAppeared)
        await store.receive(\.fetchAllResponse.success) {
            $0.todos = [Todo(id: "1", text: "todo1")]
        }
    }
    
    @MainActor
    func testViewAppearedOnFailure() async {
        let store = TestStore(initialState: TodoListFeature.State()) {
            TodoListFeature()
        } withDependencies: {
            $0.todoClient.fetchAll = {
                throw APIError.server
            }
        }
        await store.send(\.viewAppeared)
        await store.receive(\.fetchAllResponse.failure)
    }
    
    @MainActor
    func testTodoTapped() async {
        let todos = [
            Todo(id: "1", text: "todo1"),
            Todo(id: "1", text: "todo2"),
            Todo(id: "1", text: "todo3"),
            Todo(id: "1", text: "todo4"),
            Todo(id: "1", text: "todo5")
        ]
        let store = TestStore(initialState: TodoListFeature.State(todos: todos)) {
            TodoListFeature()
        }
        await store.send(\.todoTapped, "1") {
            $0.destination = .detail(.init(todo: Todo(id: "1", text: "todo1")))
        }
    }
}

enum APIError: Error {
    case server
}
