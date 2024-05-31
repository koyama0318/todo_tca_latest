import SwiftUI

public struct ListItemView: View {
    public let item: ListItem
    
    public init(item: ListItem) {
        self.item = item
    }
    
    public var body: some View {
        HStack {
            Text(item.text)
        }
    }
}

public struct ListItem: Identifiable {
    public let id: String
    let text: String
    let isChecked: Bool
    
    public init(id: String, text: String, isChecked: Bool) {
        self.id = id
        self.text = text
        self.isChecked = isChecked
    }
}

extension ListItem {
    static let mock: [Self] = [
        .init(id: UUID().uuidString, text: "text1", isChecked: true),
        .init(id: UUID().uuidString, text: "text2", isChecked: true),
        .init(id: UUID().uuidString, text: "text3", isChecked: true),
        .init(id: UUID().uuidString, text: "text4", isChecked: true),
        .init(id: UUID().uuidString, text: "text5", isChecked: true),
    ]
}
