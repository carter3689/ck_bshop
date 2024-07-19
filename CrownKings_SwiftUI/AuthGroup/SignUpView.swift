//
//  SignUpView.swift
//  crownkingsbarbershop
//
//  Created by Joel Carter on 5/26/24.
//

import SwiftUI
import Combine
import AuthenticationServices


private enum FocusableField: Hashable {
    case email
    case password
    case confirmPassword
}

struct SignUpView: View {
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    @Environment(\.dismiss) var dismiss
    
    @FocusState private var focus: FocusableField?
    
    private func signUpWithEmailPassword() {
        Task {
            if await viewModel.signUpWithEmailPassword() == true {
                dismiss()
            }
        }
    }
    
    private func signInWithGoogle() {
        Task{
            if await viewModel.signInWithGoogle() == true {
                dismiss()
            }
        }
    }
    
    @State var emailField: String = ""
    @State var passWord = ""
    @State var confirmPass = ""
    var body: some View {
        NavigationStack{
            VStack{
                ZStack {
                    Form {
                        Section(header: Text("email")
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding(EdgeInsets(top:30, leading: -10, bottom:0, trailing: 0))
                        ) {
                            ZStack(alignment: .leading){

                                TextField("Email", text: $viewModel.email)
                                    .foregroundStyle(.gray)
                                    .padding([.leading, .trailing], 16)
                                    .padding([.top, .bottom], 8)
                                    .textInputAutocapitalization(.never)
                                    .disableAutocorrection(true)
                                    .focused($focus, equals: .email)
                                    .submitLabel(.next)
                                    .onSubmit {
                                        self.focus = .password
                                    }
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.gray, lineWidth: 1)
                                            .frame(width: 353, height: 58)
                                    )
                            }
                        }
                        .listSectionSpacing(0)
                        
                        Section(header: Text("Password")
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding(EdgeInsets(top:30, leading: -10, bottom:0, trailing: 0))
                        ) {
                            ZStack(alignment: .leading){
                                SecureField("Password must be at least 8 characters", text: $viewModel.password)
                                    .foregroundStyle(.gray)
                                    .padding([.leading, .trailing], 16)
                                    .padding([.top, .bottom], 8)
                                    .focused($focus, equals: .confirmPassword)
                                    .submitLabel(.next)
                                    .onSubmit {
                                        self.focus = .confirmPassword
                                    }
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.gray, lineWidth: 1)
                                            .frame(width: 353, height: 58)
                                    )
                            }
                        }.listSectionSpacing(0)
                        
                        Section(header: Text("Confirm Password")
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding(EdgeInsets(top:30, leading: -10, bottom:0, trailing: 0))
                        ) {
                            ZStack(alignment: .leading){
                                SecureField("Password must be at least 8 characters", text: $viewModel.confirmPassword)
                                    .foregroundStyle(.gray)
                                    .padding([.leading, .trailing], 16)
                                    .padding([.top, .bottom],8)
                                    .focused($focus, equals: .confirmPassword)
                                    .submitLabel(.go)
                                    .onSubmit {
                                        signUpWithEmailPassword()
                                    }
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.gray, lineWidth: 1)
                                            .frame(width: 353, height: 58)
                                    )
                                
                                if !viewModel.errorMessage.isEmpty {
                                    VStack{
                                        Text(viewModel.errorMessage)
                                            .foregroundStyle(Color(UIColor.systemRed))
                                    }
                                }
                            }
                        }
                        
                    }.scrollContentBackground(.hidden)


                }
                
                ZStack{
                    HStack{
                        Spacer()
                        Text("Or Register with")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        Spacer()
                        
                    }
                    
                    Button(action: {
                        signUpWithEmailPassword()
                    }, label: {
                        if viewModel.authenticationState != .authenticating {
                            
                            Text("SignUp")
                                .font(.headline)
                                .foregroundStyle(.white)
                        } else {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .padding(.vertical, 8)
                                .frame(maxWidth: .infinity)
                        }

                    })
                    .frame(height: 48)
                    .frame(maxWidth:356)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(5)
                    .offset(y:-45) //Going down == less, Going up == more
                    

                }
                .offset(y:-60)
                
                ZStack{
                    LazyVGrid (columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible()),
                    ], spacing: 16, content:{
                        
                        Button(action: signInWithGoogle , label: {
                            Image("google-color-logo-icon-48.SFSymbol")
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(.red, .yellow, .blue)
                                .font(.system(size:42))
                        })
                        .buttonStyle(.bordered)
                        .controlSize(.large)
                        .tint(.gray.opacity(0.4))
                        .buttonBorderShape(.roundedRectangle(radius: 8))
                        
                        SignInWithAppleButton{request in
                            viewModel.handleSignInWithAppleRequest(request)
                            print("Started")
                        } onCompletion: { result in
                            viewModel.handleSignInWithAppleCompletion(result)
                            if case .success(_) = result {  print("Completed") }
                            
                        }
                        .frame(width:56, height: 56)
                        .signInWithAppleButtonStyle(.black)
                    })
                }.offset(y:-75)
                
                HStack{
                    Text("Already have an account?")
                        .font(.footnote)
                        .foregroundStyle(.gray)
                    Button(action: {
                        viewModel.switchFlow()
                    }, label: {
                        Text("Log In")
                            .fontWeight(.semibold)
                            .foregroundStyle(.black)
                    })
                    .offset(x:-5)
                }
                
                
                
                
                
            }.toolbar(.hidden,for: .tabBar)
            .navigationTitle("Sign Up")
                .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    SignUpView()
}
