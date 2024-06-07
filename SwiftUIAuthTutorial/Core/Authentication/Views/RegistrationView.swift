//
//  RegistrationView.swift
//  SwiftUIAuthTutorial
//
//  Created by Lauro Pimentel on 05/06/24.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var fullname = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack{
            Image("peppertools-logo").resizable().scaledToFill()
                .frame(width: 100, height: 120)
                .padding(.vertical, 32)
//              images
            
            //                form fields
                VStack(spacing:24){
                    InputView(text: $email, title: "Email", placeholder: "name@example.com")
                                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    
                    InputView(text: $fullname, title: "Full Name", placeholder: "Enter your name")
                                
                                
                    InputView(text: $password, title: "Password", placeholder: "Enter your password", isSecureField: true)
                    
                    
                    ZStack (alignment: .trailing){
                        InputView(text: $confirmPassword, title: "Confirm Password", placeholder: "Confirm your password", isSecureField: true)
                            .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                        
                        if !password.isEmpty && !confirmPassword.isEmpty{
                            if password == confirmPassword{
                                Image(systemName: "checkmark.circle.fill").imageScale(.large)
                                
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(.systemGreen))
                            }
                            else{
                                Image(systemName: "xmark.circle.fill").imageScale(.large)
                                
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(.systemRed))
                            }
                        }
                    }
                       
                }.padding(.horizontal)
              .padding(.top, 12)
            
            //                sign in button
                            Button{
                                Task{
                                    try await viewModel.createUser(withEmail:email,
                                                        password:password,fullname:fullname)
                                }
                            }label: {
                                HStack{
                                    Text("Sign up").fontWeight(.semibold)
                                    Image(systemName: "arrow.right")
                                }.foregroundColor(.white)
                                    .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                            }.background(Color(.systemBlue))
                                
                                .cornerRadius(10)
                                .padding(.top, 24)
                                .disabled(!formIsValid)
                                .opacity(formIsValid ? 1.0 : 0.5)
                               
                            
                            Spacer()
            
            Button {
                dismiss()
            } label: {
                HStack(spacing:3){
                    Text("Already have an account?")
                    Text("Sign in")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                }
                .font(.system(size: 14))
            }

            
        }
    }
}

// MARK: - AuthenticationFormProtocol
extension RegistrationView : AuthenticationFormProtocol{
    var formIsValid: Bool {
        return !email.isEmpty && email.contains("@") &&
        !password.isEmpty && password.count > 5
        && confirmPassword == password
        && !fullname.isEmpty
        
    }
}



#Preview {
    RegistrationView()
}
