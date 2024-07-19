//
//  AuthenticationView.swift
//  crownkingsbarbershop
//
//  Created by Joel Carter on 5/30/24.
//

import SwiftUI

struct AuthenticationView: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    var body: some View {
        VStack{
            switch viewModel.flow {
            case .login:
                LoginView()
                    .environmentObject(viewModel)
            case .signup:
                SignUpView()
                    .environmentObject(viewModel)
            }
        }
    }
}

#Preview {
    AuthenticationView()
}
