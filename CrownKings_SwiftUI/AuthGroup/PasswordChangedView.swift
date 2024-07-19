//
//  PasswordChangedView.swift
//  crownkingsbarbershop
//
//  Created by Joel Carter on 5/27/24.
//

import SwiftUI

struct PasswordChangedView: View {
    var body: some View {
        NavigationStack{
            VStack{
                Text("Password Changed")
                    .font(.title)
                    .fontWeight(.bold)
                    .offset(y:-40)
                Text("Your Password has been changed successfully")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    .multilineTextAlignment(.center)
                    .offset(x:-5)
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    NavigationLink(destination: HomeView()){
                        Text("Back To Home")
                            .font(.headline)
                            .foregroundStyle(.white)
                    }
                })
                .frame(width:356, height: 58)
                .buttonBorderShape(.roundedRectangle(radius: 10))
                .background(.black)
                .offset(y:20)
            }
        }
    }
}

#Preview {
    PasswordChangedView()
}
