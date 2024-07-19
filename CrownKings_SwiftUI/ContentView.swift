//
//  ContentView.swift
//  CrownKings_SwiftUI
//
//  Created by Joel Carter on 5/8/24.
//

import SwiftUI

struct ContentView: View {
    @State var tabBarVisibility: Visibility = .visible
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    @StateObject var loyaltyModel = LoyaltyViewModel()
    @StateObject var rewardModel = RewardViewModel()
    
    var body: some View {

        TabView{
            
            HomeView()
                .tabItem({
                    Label("Home", systemImage: "house")
                })
            ContactView()
                .tabItem({
                    Label("Contact Us", systemImage: "iphone")
                })
            
            LoyaltyView()
                .environmentObject(rewardModel)
                .environmentObject(loyaltyModel)
                .environmentObject(viewModel)
                .tabItem({
                    Label("Loyalty", systemImage: "creditcard")
                })
            GalleryView()
                .tabItem({
                    Label("Gallery", systemImage: "photo.on.rectangle.angled")
                })
            MoreView()
                .tabItem({
                    Label("More",systemImage: "ellipsis")
                })
        }
        .toolbar(tabBarVisibility, for: .tabBar)
    }
}

#Preview {
    ContentView()
}
