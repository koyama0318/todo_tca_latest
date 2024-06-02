import SwiftUI

public struct ListItemView: View {
    let text: String
    let icon: Icon
    let tapAction: () -> Void
    
    public init(text: String, icon: Icon, tapAction: @escaping () -> Void) {
        self.text = text
        self.icon = icon
        self.tapAction = tapAction
    }
    
    public var body: some View {
        HStack(spacing: 8) {
            IconButton(icon: icon)
            Text(text)
                .font(.body)
                .foregroundColor(Color.gray)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
        .onTapGesture(perform: tapAction)
    }
}
