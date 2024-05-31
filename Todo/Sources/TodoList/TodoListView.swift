import SwiftUI
import ComposableArchitecture
import UIComponent
import TodoDetail

public struct TodoListView: View {
    @Bindable var store: StoreOf<TodoListFeature>
    
    public init() {
        self.store = Store(initialState: TodoListFeature.State()) {
            TodoListFeature()
        }
    }
    
    public var body: some View {
        NavigationStack {
            VStack {
                ListView(
                    items: store.todos.map { ListItem(id: $0.id, text: $0.task, isChecked: false) },
                    //items: store.todos.map { ListItem(id: $0.id, text: $0.task, isChecked: $0.completed) },
                    onTap: { store.send(.todoTapped(id: $0)) }
                )
                Button(action: {store.send(.button)}) {
                    Text("aa")
                }
            }
            .onAppear { store.send(.viewAppeared) }
            .navigationDestination(
                item: $store.scope(
                    state: \.destination?.detail,
                    action: \.destination.detail
                )
            ) { store in
                TodoDetailView(store: store)
                    .toolbar(.hidden, for: .navigationBar)
            }
        }
    }
}
