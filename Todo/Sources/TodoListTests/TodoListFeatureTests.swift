import XCTest
import ComposableArchitecture
import Model

@testable import TodoList

final class TodoListFeatureTests: XCTestCase {
    private let todo = Todo(id: UUID().uuidString, task: "task", completed: false)
    
    @MainActor
    func testViewAppearedOnSuccess() async {
        let store = TestStore(initialState: TodoListFeature.State()) {
            TodoListFeature()
        } withDependencies: {
            $0.todoClient.fetchAll = {
                [self.todo]
            }
        }
        await store.send(\.viewAppeared)
        await store.receive(\.fetchedAll.success) {
            $0.todos = [self.todo]
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
        await store.receive(\.fetchedAll.failure)
    }
    
    @MainActor
    func testTodoTapped() async {
        let todos = [
            Todo(id: "1", task: "todo1", completed: false),
            Todo(id: "2", task: "todo2", completed: false),
            Todo(id: "3", task: "todo3", completed: false)
        ]
        let store = TestStore(initialState: TodoListFeature.State(todos: todos)) {
            TodoListFeature()
        }
        await store.send(\.todoTapped, "1") {
            $0.destination = .detail(.init(todo: Todo(id: "1", task: "todo1", completed: false)))
        }
    }
    
    @MainActor
    func testCheckboxTappedOnSuccess() async {
        let todos = [
            Todo(id: "1", task: "todo1", completed: false),
            Todo(id: "2", task: "todo2", completed: false),
            Todo(id: "3", task: "todo3", completed: false)
        ]
        let store = TestStore(initialState: TodoListFeature.State(todos: todos)) {
            TodoListFeature()
        }
        await store.send(\.checkboxTapped, "1")
        await store.receive(\.updated.success) {
            $0.todos = [
                Todo(id: "1", task: "todo1", completed: true),
                todos[1],
                todos[2],
            ]
        }
    }
    
    @MainActor
    func testCheckboxTappedOnFailure() async {
        let todos = [
            Todo(id: "1", task: "todo1", completed: false),
            Todo(id: "2", task: "todo2", completed: false),
            Todo(id: "3", task: "todo3", completed: false)
        ]
        let store = TestStore(initialState: TodoListFeature.State(todos: todos)) {
            TodoListFeature()
        } withDependencies: {
            $0.todoClient.update = { _ in
                throw APIError.server
            }
        }
        await store.send(\.checkboxTapped, "1")
        await store.receive(\.updated.failure)
    }
    
    @MainActor
    func testFormSubmittedOnSuccess() async {
        // 文字が空のときは何もしない
        let store = TestStore(initialState: TodoListFeature.State()) {
            TodoListFeature()
        }
        await store.send(\.formSubmitted)
        
        // 文字が入力されている場合
        var state = TodoListFeature.State()
        state.formText = "todo1"
        let store1 = TestStore(initialState: state) {
            TodoListFeature()
        }
        await store1.send(\.formSubmitted) {
            $0.formText = ""
        }
        await store1.receive(\.added.success) {
            $0.todos = [Todo(id: "1", task: "todo1", completed: false)]
        }
    }
    
    @MainActor
    func testFormSubmittedOnFailure() async {
        var state = TodoListFeature.State()
        state.formText = "todo1"
        let store = TestStore(initialState: state) {
            TodoListFeature()
        } withDependencies: {
            $0.todoClient.add = { _ in
                throw APIError.server
            }
        }
        await store.send(\.formSubmitted) {
            $0.formText = ""
        }
        await store.receive(\.added.failure)
    }
}

enum APIError: Error {
    case server
}
