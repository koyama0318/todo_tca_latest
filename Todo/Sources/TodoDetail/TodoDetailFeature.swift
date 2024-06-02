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
        case formSubmitted
        case deleteButtonTapped
        case closeButtonTapped
        case updated(Result<Todo, Error>)
        case deleted(Result<Void, Error>)
        case close
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
                
            case .formSubmitted:
                if state.todo.task == state.formText {
                    return .send(.close)
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
                
            case .deleteButtonTapped:
                return .run { [id = state.todo.id] send in
                    await send(.deleted(Result {
                        try await todoClient.delete(id)
                    }))
                }
                
            case .closeButtonTapped, .updated(.success), .deleted(.success):
                return .send(.close)
                
            case .updated(.failure), .deleted(.failure):
                print("error")
                return .none
                
            case .close:
                return .none
            }
        }
    }
}
