//
//  ResetPasswordForm.swift
//  crownkingsbarbershop
//
//  Created by Joel Carter on 5/27/24.
//

import SwiftUI

struct ResetPasswordForm: View {
    @State var newPass: String = ""
    @State var confirmPass: String = ""
    

    
    var body: some View {
        ZStack {
            Form {
                Section(header: Text("New Password")
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding(EdgeInsets(top:30, leading: -10, bottom:0, trailing: 0))
                ) {
                    
                    ZStack(alignment: .leading) {
                        if newPass.isEmpty {
                            Text("must be 8 characters")
                                .foregroundStyle(.gray)
                        }
                        TextField("", text: $newPass)
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
                
                Section(header: Text("Confirm New Password")
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding(EdgeInsets(top:30, leading: -10, bottom:0, trailing: 0))
                ) {
                    
                    ZStack(alignment: .leading) {
                        if confirmPass.isEmpty {
                            Text("repeat Password")
                                .foregroundStyle(.gray)
                        }
                        TextField("", text: $confirmPass)
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
            .offset(y:-10)

        }
    }
}

#Preview {
    ResetPasswordForm()
}
