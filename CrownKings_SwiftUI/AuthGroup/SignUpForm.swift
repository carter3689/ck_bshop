//
//  SignUpForm.swift
//  crownkingsbarbershop
//
//  Created by Joel Carter on 5/25/24.
//

import SwiftUI



struct SignUpForm: View {
    @Binding var emailField: String
    @Binding var passWord: String
    @Binding var confirmPass: String
    
    var body: some View {
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
                    }
                }.listSectionSpacing(0)
                
                Section(header: Text("Confirm Password")
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding(EdgeInsets(top:30, leading: -10, bottom:0, trailing: 0))
                ) {
                    ZStack(alignment: .leading){
                        if confirmPass.isEmpty{
                            Text("must be 8 characters")
                                .foregroundStyle(.gray)
                        }
                        SecureField("", text: $confirmPass)
                            .foregroundStyle(.gray)
                            .padding([.leading, .trailing], 16)
                            .padding([.top, .bottom],8)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 1)
                                    .frame(width: 353, height: 58)
                            )
                    }
                }
                
            }.scrollContentBackground(.hidden)


        }
    }
}

#Preview {
    VStack{
        @State var emailField = ""
        @State var passWord = ""
        @State var confirmPass = ""
        
        SignUpForm(emailField: $emailField, passWord: $passWord, confirmPass: $confirmPass)
    }
}
