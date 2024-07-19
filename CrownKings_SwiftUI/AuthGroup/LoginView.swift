//
//  LoginView.swift
//  crownkingsbarbershop
//
//  Created by Joel Carter on 5/27/24.
//

import SwiftUI
import AuthenticationServices

private enum FocusableField: Hashable {
    case email
    case password
}

struct LoginView: View {
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    @Environment(\.dismiss) var dismiss
    
    @FocusState private var focus: FocusableField?
    
    
    
    private func signInWithEmailPassword(){
        Task {
            if await viewModel.signInWithEmailPassword() == true {
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
                                    .focused($focus, equals: .email)
                                    .submitLabel(.next)
                                    .padding([.leading, .trailing], 16)
                                    .padding([.top, .bottom], 8)
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.gray, lineWidth: 1)
                                            .frame(width: 353, height: 58)
                                    )
                                    .onSubmit{
                                        self.focus = .password
                                    }
                            }
                        }
                        .listSectionSpacing(0)
                        
                        Section(header: Text("Password")
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding(EdgeInsets(top:30, leading: -10, bottom:0, trailing: 0))
                        ) {
                            ZStack(alignment: .leading){
                                SecureField("Password", text: $viewModel.password)
                                    .foregroundStyle(.gray)
                                    .focused($focus, equals: .password)
                                    .submitLabel(.go)
                                    .padding([.leading, .trailing], 16)
                                    .padding([.top, .bottom], 8)
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.gray, lineWidth: 1)
                                            .frame(width: 353, height: 58)
                                    )
                                    .onSubmit{
                                        signInWithEmailPassword()
                                    }
                            }.listSectionSpacing(0)
                            }

                    }
                    .scrollContentBackground(.hidden)
                    ZStack{
                        NavigationLink(destination: ForgotPasswordView()){
                            Text("Forgot Password")
                                .font(.callout)

                                .foregroundColor(.black)
                                .cornerRadius(10)
                        }
                    }.offset(x:105, y:15)
                    Button(action: {
                        signInWithEmailPassword()
                        print("\(viewModel.email)")
                    }, label: {
                        if viewModel.authenticationState != .authenticating {
                            
                            Text("Login")
                                .font(.headline)
                                .foregroundStyle(.white)
                        } else {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .frame(maxWidth: .infinity)
                        }

                    })
                    .disabled(!viewModel.isValid)
                    .frame(height: 48)
                    .frame(maxWidth:356)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(5)
                    .offset(y:80)

                }
                
                
                ZStack{
                    HStack{
                        Spacer()
                        Text("Or Log In with")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        Spacer()
                    }

                }
                .offset(y:-90)
                
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
                    Text("Don't have an account?")
                        .font(.footnote)
                        .foregroundStyle(.gray)
                    Button(action: {
                        viewModel.switchFlow()
                    }, label: {
                        Text("Sign Up")
                            .fontWeight(.semibold)
                            .foregroundStyle(.black)
                    })
                    .offset(x:-5)
                }
                
                
                
                
                
            }.toolbar(.hidden,for: .tabBar)
            .navigationTitle("Log In")
                .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    LoginView()
}
