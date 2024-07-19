//
//  HomeView.swift
//  CrownKings_SwiftUI
//
//  Created by Joel Carter on 5/8/24.
//

import SwiftUI

let BackgroundLogo = Image("CrownKingsLogo")



let CrownKingsMainPhoto = Image("crown_kings_main_photo")


struct HomeView: View {
    @Environment(\.openURL) private var openURL
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack{
            ZStack{
                BackgroundLogo
                    .offset(y:43)
                VStack{

                    CrownKingsMainPhoto
                        .resizable()
                        .frame(width:300,height:250)
                        .aspectRatio(contentMode: .fill)
                        .navigationTitle("Home")
                    Spacer()
                    Button{
                        if let url = URL(string:"https://crownkingsbarbershop.as.me/"){
                            openURL(url)
                        }
                    } label: {
                        Text("Book Appointment")
                            .font(.largeTitle)
                            .padding(.horizontal,22.0)
                        .frame(height:92.0)
                        .foregroundColor(colorScheme == .dark ? .black : .white)
                        .background(colorScheme == .dark ? .white : .black)
                        .cornerRadius(8)
                    }
                    .tint(colorScheme == .dark ? .white : .black)
                    .buttonStyle(.plain)
                    .offset(y:-60)
                }
            }
            .backgroundStyle(colorScheme == .dark ? .black : .white)

        }
    }
}

#Preview {
    HomeView()
}
