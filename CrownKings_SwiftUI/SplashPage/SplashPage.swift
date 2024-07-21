//
//  SplashPage.swift
//  crownkingsbarbershop
//
//  Created by Joel Carter on 7/19/24.
//

import SwiftUI

struct SplashPage: View {
    
    @State var isActive: Bool = false
    
    var body: some View {
        ZStack{
            if self.isActive {
                HomeView()
            } else {
                Rectangle()
                    .background(Color.black)
                Image("CrownKingsLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
            }
        }
        .onAppear() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    self.isActive = true
                    print("Splash Screen Appeared Here")
                }
            }
        }
    }
}

#Preview {
    SplashPage()
}
