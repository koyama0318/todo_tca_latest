import SwiftUI

public struct FormView: View {
    @Binding private var text: String
    let placeholder: String
    let buttonText: String
    let action: () -> Void
    
    public init(
        text: Binding<String>,
        placeholder: String,
        buttonText: String,
        onSubmit action: @escaping () -> Void
    ) {
        self._text = text
        self.placeholder = placeholder
        self.buttonText = buttonText
        self.action = action
    }

    public var body: some View {
        HStack {
            TextField(placeholder, text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Button(action: action) {
                Text(buttonText)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
        }
    }
}
