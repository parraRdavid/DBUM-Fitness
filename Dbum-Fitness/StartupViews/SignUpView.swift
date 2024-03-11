//
//  SignUpView.swift
//  Dbum-Fitness
//
//  Created by iMac on 11/3/23.
//

import SwiftUI

struct SignUpView: View {
    
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @EnvironmentObject var viewModel: AuthViewModel

    var body: some View {
        
        NavigationStack {
            ZStack{
                VStack {
                    VStack(spacing: 20){
                        SignIn_UpFonts(title: "DBUM FITNESS")
                            .font(Font.custom("AppleGothic", fixedSize: 35))
                            .bold()
                        
                        SignIn_UpFonts(title: "Sign Up Here")
                            .font(Font.custom("AppleGothic", fixedSize: 23))
                            .bold()
                        
                        NavigationLink {
                            accountRequirementsView()
                            
                        }label: {
                            HStack(spacing: 3){
                                Text("Account Requirements")
                                    .fontWeight(.bold)
                                    .underline()
                                    .font(Font.custom("AppleGothic", fixedSize: 18))
                            }
                            .foregroundColor(Color.black)
                            .font(Font.custom("AppleGothic", fixedSize: 15))
                            
                        }
                    }
                    .padding()
                    
                    Group{
                        VStack(alignment: .center, spacing: 40){
                            VStack(alignment: .leading, spacing: 5){
                                SignIn_UpFonts(title: "Email")
                                    .font(Font.custom("AppleGothic", fixedSize: 16))
                                TextField("", text: $email)
                            }
                            
                            VStack(alignment: .leading, spacing: 5){
                                SignIn_UpFonts(title: "Username")
                                    .font(Font.custom("AppleGothic", fixedSize: 16))
                                TextField("", text: $username)
                                
                            }
                            
                            VStack(alignment: .leading, spacing: 5){
                                SignIn_UpFonts(title: "Password")
                                    .font(Font.custom("AppleGothic", fixedSize: 16))
                                SecureField("", text: $password)
                            }
                            
                            VStack(alignment: .leading, spacing: 5){
                                SignIn_UpFonts(title: "Confirm Password")
                                    .font(Font.custom("AppleGothic", fixedSize: 16))
                                
                                ZStack{
                                    SecureField("", text: $confirmPassword)
                                    if !password.isEmpty && !confirmPassword.isEmpty {
                                        if password == confirmPassword {
                                            Image(systemName: "checkmark.circle.fill")
                                                .imageScale(.large)
                                                .fontWeight(.bold)
                                                .foregroundColor(Color(.systemGreen))
                                        }else{
                                            Image(systemName: "xmark.circle.fill")
                                                .imageScale(.large)
                                                .fontWeight(.bold)
                                                .foregroundColor(Color(.systemRed))
                                        }
                                    }
                                }
                            }
                        }
                    }
                    Button {
                        Task{
                            try await viewModel.createUser(withEmail: email, password: password, username: username)
                        }
                    } label: {
                        HStack{
                            Text("SIGN UP")
                                .fontWeight(.semibold)
                                .font(Font.custom("AppleGothic", fixedSize: 18))
                            Image(systemName: "arrow.right")
                        }
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width - 50, height: 48)
                        
                    }
                    .background(Color.indigo)
                    .cornerRadius(10)
                    .disabled(!formIsValid)
                    .opacity(formIsValid ? 1.0 : 0.5)
                    .padding(.top, 24)
                    
                    Spacer()
                    
                    NavigationLink {
                        LoginView()
                        
                    }label: {
                        HStack(spacing: 3){
                            Text("Already an account?")
                            Text("Sign In")
                                .fontWeight(.bold)
                                .underline()
                                .font(Font.custom("AppleGothic", fixedSize: 18))
                        }
                        .foregroundColor(Color.black)
                        .font(Font.custom("AppleGothic", fixedSize: 15))
                        
                    }
                }
                .padding()
                .textFieldStyle(TextFieldBorder())
            }
        }
    }
}
extension SignUpView: AuthenFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 6
        && confirmPassword == password
        && !username.isEmpty
    }
}
struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
