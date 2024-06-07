//
//  LoginView.swift
//  SwiftUIAuthTutorial
//
//  Created by Lauro Pimentel on 05/06/24.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var errorMsg = ""
    @State private var showAlert = false
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        NavigationStack{
            
            VStack {
                Image("peppertools-logo").resizable().scaledToFill()
                    .frame(width: 100, height: 120)
                    .padding(.vertical, 32)
//              images
                
//                form fields
                VStack(spacing:24){
                    InputView(text: $email, title: "Email", placeholder: "name@example.com")
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    
                    InputView(text: $password, title: "Password", placeholder: "Enter your password", isSecureField: true)
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                }.padding(.horizontal)
                    .padding(.top, 12)
//                sign in button
                Button{
                    Task{
                        errorMsg = try await viewModel.signIn(withEmail: email, password: password)
                        showAlert = !errorMsg.isEmpty
                        
                    }
                    
                }label: {
                    HStack{
                        Text("Sign in").fontWeight(.semibold)
                        Image(systemName: "arrow.right")
                    }.foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                }.background(Color(.systemBlue))
//
                    .cornerRadius(10)
                    .padding(.top, 24)
                    .disabled(!formIsValid)
                                      .opacity(formIsValid ? 1.0 : 0.5)
                   
                    .alert("Error",isPresented: $showAlert){
                        Button("OK") { }
                    }message: {
                        Text("\($errorMsg.wrappedValue)")
                    }
                
                Spacer()
//                sign up button
                
                NavigationLink{
                    RegistrationView()
                        .navigationBarBackButtonHidden(true)
                }label: {
                    HStack(spacing:3){
                        Text("Don't have an account?")
                        Text("Sign up")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    }
                    .font(.system(size: 14))
                }
                
            }
        }
    }
}
// MARK: - AuthenticationFormProtocol
extension LoginView : AuthenticationFormProtocol{
    var formIsValid: Bool {
        return !email.isEmpty && email.contains("@") &&
        !password.isEmpty && password.count > 5
        
    }
}

#Preview {
    LoginView()
}
