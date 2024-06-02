import SwiftUI
import ComposableArchitecture
import UIComponent

public struct TodoDetailView: View {
    @Bindable var store: StoreOf<TodoDetailFeature>
    
    public init(store: StoreOf<TodoDetailFeature>) {
        self.store = store
    }
    
    public var body: some View {
        VStack(spacing: 16) {
            NavigationBar(
                left: .init(type: .chevronLeft, action: { store.send(.closeButtonTapped) }),
                right: .init(type: .trash, action: { store.send(.deleteButtonTapped) })
            )
            FormView(
                text: $store.formText,
                placeholder: "Edit task",
                buttonText: "Save",
                onSubmit: { store.send(.formSubmitted) }
            )
            Spacer()
        }
    }
}
