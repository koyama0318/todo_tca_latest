import XCTest
import ComposableArchitecture
import Model

@testable import TodoDetail

final class TodoDetailFeatureTests: XCTestCase {
    private let todo = Todo(id: UUID().uuidString, text: "text")
    
    @MainActor
    func testViewAppeared() async {
        let store = TestStore(initialState: TodoDetailFeature.State(todo: todo)) {
            TodoDetailFeature()
        }
        
        await store.send(\.viewAppeared)
    }
    
    @MainActor
    func testCloseButtonTapped() async {
        let store = TestStore(initialState: TodoDetailFeature.State(todo: todo)) {
            TodoDetailFeature()
        }
        
        await store.send(\.closeButtonTapped)
    }
}
