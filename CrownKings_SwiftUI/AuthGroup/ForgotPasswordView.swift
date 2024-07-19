//
//  ForgotPasswordView.swift
//  crownkingsbarbershop
//
//  Created by Joel Carter on 5/25/24.
//

import SwiftUI

struct ForgotPasswordView: View {
    var body: some View {
        NavigationStack{
            VStack{
                Text("Don't worry! It happens. Please enter the email associated with your account")
                    .foregroundStyle(.gray)
                    .offset(y:20)
                Spacer()
                ForgotPasswordForm()
                
            }.navigationTitle("Forgot Password")
        }
    }
}

#Preview {
    ForgotPasswordView()
}
