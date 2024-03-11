
import Foundation
import SwiftUI

struct PressableButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundColor(Color.white)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(Color.indigo)
            .cornerRadius(10)
            .shadow(color: Color.blue.opacity(0.3), radius: 10, x: 0.0, y: 10)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .opacity(configuration.isPressed ? 0.9 : 1.0)
    }
}


struct TextFieldBorder: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .frame(width: 300)
            .foregroundColor(Color.black)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.black, lineWidth:2)
            )
    }
}

struct TextFieldBorder2: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .foregroundColor(Color.black)
            .frame(width: 300, height: 35)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.black, lineWidth:2)
            )
    }
}
struct SignIn_UpFonts: View {
    
    var title: String
    
    var body: some View {
        
        Text("\(title)")
        
            .foregroundColor(.black)
            .fontWeight(.black)
            .kerning(5)
    }
}

struct MainHubCardViews: View {
    
    var title: String
    var body: some View {
        VStack {
            Text("\(title)")
                .font(Font.custom("AppleGothic", fixedSize: 30))
                .tracking(4)
                .foregroundColor(.white)
                .fontWeight(.black)
        } //VStack
        .frame(maxWidth: 270, minHeight: 50)
        .padding(30)
        .background(.indigo)
        .cornerRadius(20)
    }
}
