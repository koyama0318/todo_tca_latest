import Client
import ComposableArchitecture
import Foundation
import Model

@Reducer
public struct TodoDetailFeature {
    @ObservableState
    public struct State: Equatable {
        var todo: Todo
        var formText: String
        
        public init(todo: Todo) {
            self.todo = todo
            self.formText = todo.task
        }
    }
    
    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case viewAppeared
        case deleteButtonTapped
        case closeButtonTapped
        case updated(Result<Todo, Error>)
        case deleted(Result<Void, Error>)
    }
    
    @Dependency(TodoClient.self) var todoClient
    @Dependency(\.dismiss) var dismiss
    
    public init() {}
    
    public var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding:
                return .none
                
            case .viewAppeared:
                return .none
                
            case .deleteButtonTapped:
                let id = state.todo.id
                return .run { send in
                    await send(.deleted(Result {
                        try await todoClient.delete(id)
                    }))
                }
                
            case .closeButtonTapped:
                if state.todo.task == state.formText {
                    return close()
                }
                let newTodo = Todo(
                    id: state.todo.id,
                    task: state.formText,
                    completed: state.todo.completed
                )
                return .run { send in
                    await send(.updated(Result {
                        try await todoClient.update(newTodo)
                    }))
                }
                
            case .updated(.success), .deleted(.success):
                return close()
                
            case .updated(.failure), .deleted(.failure):
                print("error")
                return .none
            }
        }
    }
    
    private func close() -> Effect<Action> {
        return .run { _ in await self.dismiss() }
    }
}
