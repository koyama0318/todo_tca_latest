import Client
import ComposableArchitecture
import Foundation
import Model

@Reducer
public struct TodoDetailFeature {
    @ObservableState
    public struct State {
        var todo: Todo
        
        public init(todo: Todo) {
            self.todo = todo
        }
    }
    
    public enum Action {
        case viewAppeared
        case closeButtonTapped
    }
    
    @Dependency(TodoClient.self) var todoClient
    @Dependency(\.dismiss) var dismiss
    
    public init() {}
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .viewAppeared:
                return .none
                
            case .closeButtonTapped:
                return .run { _ in await self.dismiss() }
            }
        }
    }
}
