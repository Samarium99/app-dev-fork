//
//  LoginView.swift
//  Login for App
//
//  Created by student on 4/29/24.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel

    var body: some View {
        NavigationStack {
            VStack {
                // image
                Image("Plant4")
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 120)
                .padding(.vertical, 32)
                
                
                // form fields
                VStack(spacing: 24) {
                    InputView (text: $email,
                               title: "Email Address",
                               placeholder: "name@example.com")
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    
                    InputView(text: $password, title: "Password", placeholder: "Enter your password",
                        isSecureField: true)
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                // sign in button
                
                Button{
                    Task {
                      try await viewModel.signIn(withEmail: email, password: password)
                    }
                } label: {
                    HStack {
                        Text("SIGN IN")
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.right")
                    }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                }
                .background(Color(.systemBlue))
                .disabled(!formValid)
                .opacity(formValid ? 1.0 : 0.5)
                .cornerRadius(10)
                .padding(.top, 24)
               
                Spacer()
                
                // sign up button
                NavigationLink {
                    RegistrationView()
                        .navigationBarBackButtonHidden()
                    //Hides the back button but can be deleted
                    
                } label : {
                    HStack(spacing: 3) {
                        Text ("Don't have an account?")
                        Text ("Sign Up")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    }
                            .font(.system(size: 14))
                }
            }
        }
    }
}

//Mark - AuthenticationFormProtocol


extension LoginView:
    AuthenticationFormProtocol {
    var formValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
    }
}

struct LoginView_Preview:
    PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
