import SwiftUI
import ComposableArchitecture
import UIComponent

public struct TodoListView: View {
    let store: StoreOf<TodoListFeature>
    
    public init() {
        self.store = Store(initialState: TodoListFeature.State()) {
            TodoListFeature()
        }
    }
    
    public var body: some View {
        VStack {
            ListView(
                items: store.todos.map { ListItem(id: $0.id, text: $0.text) },
                onTap: { store.send(.todoTapped) }
            )
        }
        .onAppear { store.send(.viewAppeared) }
    }
}
