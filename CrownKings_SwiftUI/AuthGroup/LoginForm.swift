//
//  LoginForm.swift
//  crownkingsbarbershop
//
//  Created by Joel Carter on 5/25/24.
//

import SwiftUI

struct LoginForm: View {
    @Binding var emailField: String
    @Binding var passWord: String
    
    var body: some View {
        NavigationStack {
            ZStack {
                Form {
                    Section(header: Text("email")
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding(EdgeInsets(top:30, leading: -10, bottom:0, trailing: 0))
                    ) {
                        ZStack(alignment: .leading){
                            if emailField.isEmpty{
                                Text("email")
                                    .foregroundStyle(.gray)
                            }
                            TextField("", text: $emailField)
                                .foregroundStyle(.gray)
                                .padding([.leading, .trailing], 16)
                                .padding([.top, .bottom], 8)
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
                            if passWord.isEmpty{
                                Text("must be 8 characters")
                                    .foregroundStyle(.gray)
                            }
                            SecureField("", text: $passWord)
                                .foregroundStyle(.gray)
                                .padding([.leading, .trailing], 16)
                                .padding([.top, .bottom], 8)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray, lineWidth: 1)
                                        .frame(width: 353, height: 58)
                                )
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
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Login")
                        .font(.headline)
                        .foregroundStyle(.white)
                })
                .frame(height: 48)
                .frame(maxWidth:356)
                .background(Color.black)
                .foregroundColor(.white)
                .cornerRadius(5)
                .offset(y:80)

            }
        }
    }
}

#Preview {
    VStack{
        @State var emailField: String = ""
        @State var passWord: String = ""
        
        LoginForm(emailField: $emailField, passWord: $passWord)
    }
}
