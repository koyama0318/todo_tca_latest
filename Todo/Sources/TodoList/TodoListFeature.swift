import ComposableArchitecture
import Client
import Foundation
import Model
import TodoDetail

@Reducer
public struct TodoListFeature {
    @ObservableState
    public struct State: Equatable {
        @Presents var destination: Destination.State?
        var todos: [Todo]
        var formText: String
        
        public init(todos: [Todo] = []) {
            self.destination = nil
            self.todos = todos
            self.formText = ""
        }
    }
    
    @Reducer(state: .equatable)
    public enum Destination {
        case detail(TodoDetailFeature)
    }
    
    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case destination(PresentationAction<Destination.Action>)
        case viewAppeared
        case todoTapped(id: String)
        case checkboxTapped(id: String)
        case formSubmitted
        case fetchedAll(Result<[Todo], Error>)
        case added(Result<Todo, Error>)
        case updated(Result<Todo, Error>)
    }
    
    @Dependency(TodoClient.self) var todoClient
    
    public init() {}
    
    public var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding:
                return .none
                
            case .destination(.presented(.detail(.close))):
                state.destination = nil
                return fetchAll()
                
            case .destination:
                return .none
                
            case .viewAppeared:
                return state.todos.isEmpty ? fetchAll() : .none
                
            case .todoTapped(let id):
                if let todo = state.todos.first(where: { $0.id == id }) {
                    state.destination = .detail(.init(todo: todo))
                }
                return .none
                
            case .checkboxTapped(let id):
                guard let todo = state.todos.first(where: { $0.id == id }) else {
                    return .none
                }
                let updated = Todo(id: todo.id, task: todo.task, completed: !todo.completed)
                return .run { send in
                    await send(.updated(Result {
                        try await todoClient.update(updated)
                    }))
                }
                
            case .formSubmitted:
                if state.formText.isEmpty {
                    return .none
                }
                let newTask = state.formText
                state.formText = ""
                return .run { send in
                    await send(.added(Result {
                        try await todoClient.add(newTask)
                    }))
                }
                
            case .fetchedAll(.success(let todos)):
                state.todos = todos
                return .none
                
            case .added(.success(let todo)):
                state.todos.append(todo)
                return .none
                
            case .updated(.success(let todo)):
                if let idx = state.todos.firstIndex(where: { $0.id == todo.id }) {
                    state.todos[idx] = todo
                }
                return .none
                
            case .fetchedAll, .added, .updated:
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination)
    }
    
    private func fetchAll() -> Effect<Action> {
        return .run { send in
            await send(.fetchedAll(Result {
                try await todoClient.fetchAll()
                
            }))
        }
    }
}
