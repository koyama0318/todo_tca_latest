import ComposableArchitecture
import Client
import Model

@Reducer
struct TodoListFeature {
    @ObservableState
    struct State {
        var todos: [Todo] = []
    }
    
    enum Action {
        case viewAppeared
        case todoTapped
        case fetchAllResponse(Result<[Todo], Error>)
    }
    
    @Dependency(\.todoClient) var todoClient
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .viewAppeared:
                return fetchTodoListAll()
                
            case .todoTapped:
                print("todo tap")
                return .none
                
            case .fetchAllResponse(.success(let todos)):
                state.todos = todos
                return .none
                
            case .fetchAllResponse(.failure(let error)):
                print(error.localizedDescription)
                return .none
            }
        }
    }
    
    private func fetchTodoListAll() -> Effect<Action> {
        return .run { send in
            await send(.fetchAllResponse(Result {
                try await todoClient.fetchAll()
            }))
        }
    }
}
