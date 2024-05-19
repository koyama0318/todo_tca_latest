import SwiftUI
import ComposableArchitecture

public struct TodoDetailView: View {
    let store: StoreOf<TodoDetailFeature>
    
    public init(store: StoreOf<TodoDetailFeature>) {
        self.store = store
    }
    
    public var body: some View {
        VStack {
            Button(action: { store.send(.closeButtonTapped) }) {
                Text("close")
            }
            Text(store.todo.id)
            Text(store.todo.text)
        }
    }
}
