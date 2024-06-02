import SwiftUI

public struct NavigationBar: View {
    let left: Icon
    let right: Icon
    
    public init(left: Icon, right: Icon) {
        self.left = left
        self.right = right
    }
    
    public var body: some View {
        HStack {
            IconButton(icon: left)
            Spacer()
            IconButton(icon: right)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
    }
}
