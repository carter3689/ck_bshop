//
//  SocialButton.swift
//  crownkingsbarbershop
//
//  Created by Joel Carter on 5/26/24.
//

import SwiftUI

struct SocialButton: View {
    let socialNetwork: SocialNewtwork
    let action: () -> Void
    
    var body: some View {
        Button(action:action) {
            
        }
    }
}

#Preview {
    VStack{
        ForEach(SocialNetwork.all)
        SocialButton(socialNetwork:)
    }
}

enum SocialNewtwork: String, CaseIterable {
    case facebook = "Facebook"
    case apple = "Apple"
    case google = "Google"
    
    var imageName: String {
        switch self {
        case .facebook: return "f.circle"
        case .apple: return "applelogo"
        case .google: return "g.circle"
        }
    }
    
    var backgroundColor: Color {
        switch self{
        case .facebook: return Color.blue
        case .apple: return Color.gray
        case .google: return Color.red
        }
    }
}
