import ComposableArchitecture
import Client

@Reducer
struct TodoListFeature {
    @ObservableState
    struct State: Equatable {
        var count = 0
    }
    
    enum Action {
        case buttonTapped
    }
    
    @Dependency(\.todoClient) var todoClient
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .buttonTapped:
                return .none
            }
        }
    }
}
