import SwiftUI

public struct ListView: View {
    let items: [ListItem]
    let onTap: (_ id: String) -> Void
    
    public init(items: [ListItem], onTap: @escaping (String) -> Void) {
        self.items = items
        self.onTap = onTap
    }
    
    public var body: some View {
        ForEach(items) { item in
            ListItemView(item: item)
                .onTapGesture {
                    onTap(item.id)
                }
        }
    }
}

#Preview {
    ListView(items: ListItem.mock, onTap: { _ in })
}
