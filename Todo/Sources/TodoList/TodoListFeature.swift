import Client
import TodoDetail
import ComposableArchitecture
import Foundation
import Model

@Reducer
public struct TodoListFeature {
    @ObservableState
    public struct State: Equatable {
        @Presents var destination: Destination.State?
        var todos: [Todo]
        
        public init(todos: [Todo] = []) {
            self.destination = nil
            self.todos = todos
        }
    }
    
    @Reducer(state: .equatable)
    public enum Destination {
        case detail(TodoDetailFeature)
    }
    
    public enum Action {
        case destination(PresentationAction<Destination.Action>)
        case viewAppeared
        case button
        case todoTapped(id: String)
        case fetchAllResponse(Result<[Todo], Error>)
    }
    
    @Dependency(TodoClient.self) var todoClient
    
    public init() {}
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .destination(_):
                return .none
                
            case .viewAppeared:
                return fetchTodoListAll()
                
            case .button:
                return fetchTodoListAll()
                
            case .todoTapped(let id):
                guard let todo = state.todos.first(where: { $0.id == id }) else {
                    return .none
                }
                state.destination = .detail(.init(todo: todo))
                return .none
                
            case .fetchAllResponse(.success(let todos)):
                state.todos = todos
                return .none
                
            case .fetchAllResponse(.failure(let error)):
                print(error.localizedDescription)
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination)
    }
    
    private func fetchTodoListAll() -> Effect<Action> {
        return .run { send in
            await send(.fetchAllResponse(Result {
                try await todoClient.fetchAll()
            }))
        }
    }
}
