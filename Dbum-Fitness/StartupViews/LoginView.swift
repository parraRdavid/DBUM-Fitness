
import SwiftUI

struct LoginView: View {
    
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
  
        NavigationStack {
            ZStack{
                VStack {
                    VStack(spacing: 50){
                        
                        SignIn_UpFonts(title: "DBUM FITNESS")
                            .font(Font.custom("AppleGothic", fixedSize: 35))
                            .bold()
                        
                        SignIn_UpFonts(title: "Sign In Heree")
                            .font(Font.custom("AppleGothic", fixedSize: 23))
                            .bold()
                        
                    }
                    .padding()
                    
                    Spacer()
                        .frame(height: 100)
                    
                    Group{
                        
                        VStack(alignment: .leading, spacing: 5){
                            SignIn_UpFonts(title: "Email")
                                .font(Font.custom("AppleGothic", fixedSize: 16))
                            TextField("", text: $email)
                        }
                        
                        Spacer()
                            .frame(height: 40)
                        
                        VStack(alignment: .leading, spacing: 5){
                            SignIn_UpFonts(title: "Password")
                                .font(Font.custom("AppleGothic", fixedSize: 16))
                            
                            SecureField("Do not forget it :)", text: $password)
                        }
                    }
                    
                    Spacer()
                        .frame(height: 50)
                    
                    Button{
                        Task{
                            try await viewModel.signIn(withEmail: email, password: password)
                        }
                    } label: {
                        HStack{
                            Text("SIGN IN")
                                .fontWeight(.semibold)
                                .font(Font.custom("AppleGothic", fixedSize: 18))
                            Image(systemName: "arrow.right")
                        }
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width - 20, height: 48)
                    }
                    .background(Color.indigo)
                    .disabled(!formIsValid)
                    .opacity(formIsValid ? 1.0 : 0.5)
                    .cornerRadius(10)
                    .padding(.top, 24)
                    
                    Spacer()
                    
                    NavigationLink {
                        SignUpView()
                            .navigationBarBackButtonHidden(true)
                    }label: {
                        HStack(spacing: 3){
                            Text("Don't have an account?")
                            Text("Sign Up")
                                .fontWeight(.bold)
                                .underline()
                                .font(Font.custom("AppleGothic", fixedSize: 18))
                            
                        }
                        .foregroundColor(Color.black)
                        .font(Font.custom("AppleGothic", fixedSize: 15))
                    }
                }
                .padding(20)
                .textFieldStyle(TextFieldBorder())
            }
        }
    }
}

extension LoginView: AuthenFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 6
    }
}
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
