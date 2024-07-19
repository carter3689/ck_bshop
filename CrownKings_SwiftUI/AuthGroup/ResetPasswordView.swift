//
//  ResetPasswordView.swift
//  crownkingsbarbershop
//
//  Created by Joel Carter on 5/27/24.
//

import SwiftUI

struct ResetPasswordView: View {
    var body: some View {
        NavigationStack{
            VStack{
                ResetPasswordForm()
            }.navigationTitle("Reset Password")
        }
    }
}

#Preview {
    ResetPasswordView()
}
