import SwiftUI

struct IconButton: View {
    let icon: Icon
    
    var body: some View {
        Button(action: icon.action) {
            Image(systemName: icon.name)
                .frame(width: 24, height: 24)
        }
    }
}

public struct Icon: Identifiable {
    public let id = UUID().uuidString
    public let name: String
    public let action: () -> Void
    
    public init(type: IconType, action: @escaping () -> Void) {
        self.name = type.rawValue
        self.action = action
    }
}

public enum IconType: String {
    case checkmark = "checkmark.square"
    case square
    case pencil
    case trash
    case chevronLeft = "chevron.left"
}
