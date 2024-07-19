//
//  ContactView.swift
//  CrownKings_SwiftUI
//
//  Created by Joel Carter on 5/8/24.
//

import SwiftUI

struct ContactView: View {
    @Environment(\.openURL) private var openURL
    @State var toLat: String = ""
    @State var toLong: String = ""
    
    var body: some View {
        NavigationStack{
            ZStack{
                VStack{

                    CrownKingsMainPhoto
                        .resizable()
                        .frame(width:300,height:250)
                        .aspectRatio(contentMode: .fit)
                        .navigationTitle("Contact")
                    Spacer()
                    //Get Directions Button
                    Button{
                        if let url = URL(string:"https://g.co/kgs/35fPn8f"){
                            openURL(url)
                        }
                    } label: {
                        Text("Get Directions")
                            .font(.largeTitle)
                            .padding(.horizontal,22.0)
                        .frame(height:92.0)
                        .foregroundColor(.white)
                        .background(.black)
                        .cornerRadius(8)
                    }
                    .tint(.black)
                    .buttonStyle(.plain)
                    .offset(y:-40)
                    Spacer()
                    
                    // Call for Walk-In Button
                    Button{
                        if let url = URL(string:"tel: +1-708-261-1817"),
                           UIApplication.shared.canOpenURL(url) {
                            UIApplication.shared.open(url)
                        }
                    } label: {
                        HStack{
                            Image(systemName: "phone.fill")
                                .frame(width: 6.0, height: 6.0)
                            Text("Call For Walk-In")
                                .font(.largeTitle)
                        }
                        .padding(.horizontal,22.0)
                        .frame(height:92.0)
                        .foregroundColor(.white)
                        .background(.black)
                        .cornerRadius(8)
                    }
                    .tint(.black)
                    .buttonStyle(.plain)
                    .offset(y:-60)
                }
            }

        }
    }
}

#Preview {
    ContactView()
}
