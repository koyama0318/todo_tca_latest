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
            ScrollView {
                VStack {
                    FormView(
                        text: $store.formText,
                        placeholder: "Enter new task",
                        buttonText: "Add",
                        onSubmit: { store.send(.formSubmitted) }
                    )
                    ForEach(store.todos) { todo in
                        ListItemView(
                            text: todo.task,
                            icon: Icon(
                                type: todo.completed ? .checkmark : .square,
                                action: { store.send(.checkboxTapped(id: todo.id)) }
                            ),
                            tapAction: { store.send(.todoTapped(id: todo.id)) }
                        )
                    }
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
