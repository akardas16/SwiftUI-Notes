 Button {
                
            } label: {
                Label("Sign Up", systemImage: "book.fill").foregroundColor(.green).font(.system(size: 18, weight: .regular, design: .rounded))
                    .frame(maxWidth:.infinity).frame(height:50).background(.green.opacity(0.2)).cornerRadius(25)
                   .padding(.horizontal,32)
            }.buttonStyle(MyButtonStyle())



struct MyButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? CGFloat(0.85) : 1.0)
            .animation(Animation.spring(response: 0.35, dampingFraction: 0.35, blendDuration: 1), value: configuration.isPressed)
    }
}