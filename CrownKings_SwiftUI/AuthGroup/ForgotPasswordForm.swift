//
//  ForgotPasswordForm.swift
//  crownkingsbarbershop
//
//  Created by Joel Carter on 5/25/24.
//

import SwiftUI



struct ForgotPasswordForm: View {
    @State var emailField: String = ""
    @State var passWord: String = ""
    @State var confirmPass: String = ""
    

    
    var body: some View {
        ZStack {
            Form {
                Section(header: Text("email")
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding(EdgeInsets(top:30, leading: -10, bottom:0, trailing: 0))
                ) {
                    
                    ZStack(alignment: .leading) {
                        if emailField.isEmpty {
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
                                    .frame(width:353, height: 58)
                                    
                            )
                    }
                }
                .listSectionSpacing(0)
                
                
            }
            .scrollContentBackground(.hidden)
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Text("Send Code")
                    .font(.headline)
                    .foregroundStyle(.white)
            })
            .frame(height: 48)
            .frame(maxWidth:356)
            .background(Color.black)
            .foregroundColor(.white)
            .cornerRadius(5)
            .offset(y:-135)

        }
    }
}

#Preview {
    ForgotPasswordForm()
}
