import SwiftUI

public struct ListView: View {
    let items: [ListItem]
    let onTap: () -> Void
    
    public init(items: [ListItem], onTap: @escaping () -> Void) {
        self.items = items
        self.onTap = onTap
    }
    
    public var body: some View {
        ForEach(items) { item in
            ListItemView(item: item)
                .onTapGesture(perform: onTap)
        }
    }
}

struct ListItemView: View {
    let item: ListItem
    
    var body: some View {
        HStack {
            Text(item.text)
        }
    }
}

public struct ListItem: Identifiable {
    public let id: String
    let text: String
    
    public init(id: String, text: String) {
        self.id = id
        self.text = text
    }
}

let mockListItems: [ListItem] = [
    .init(id: UUID().uuidString, text: "text1"),
    .init(id: UUID().uuidString, text: "text2"),
    .init(id: UUID().uuidString, text: "text3"),
    .init(id: UUID().uuidString, text: "text4"),
    .init(id: UUID().uuidString, text: "text5"),
]

#Preview {
    ListView(items: mockListItems, onTap: {})
}
