import SwiftUI
import ComposableArchitecture

public struct TodoListView: View {
    let store: StoreOf<TodoListFeature>
    
    public init() {
        self.store = Store(initialState: TodoListFeature.State()) {
            TodoListFeature()
        }
    }
    
    public var body: some View {
        VStack {
            Text("todo")
        }
    }
}
