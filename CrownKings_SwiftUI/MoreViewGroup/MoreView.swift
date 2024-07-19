//
//  MoreView.swift
//  CrownKings_SwiftUI
//
//  Created by Joel Carter on 5/8/24.
//

import SwiftUI

struct MoreView: View {
    var moreItems: [MoreItem] = [
        .init(mainText: "Share With Friends", subText: "Earn More rewards",viewDisplay: "ShareView"),
        .init(mainText: "Account", subText: "Manage Your Account", viewDisplay: "AccountView")
    ]
    
    
    var body: some View {
        NavigationStack {
            List {
                Section("Additional Items") {
                    ForEach(moreItems, id:\.mainText) { moreItem in
                        NavigationLink(destination: createView(for: moreItem.viewDisplay) ){
                            LabeledContent(moreItem.mainText, value: moreItem.subText)
                        }
                    }
                }
            }
            .navigationTitle("More")
        }
    }
    @ViewBuilder //Make the function below a view builder
    func createView(for viewDisplay: String) -> some View {
        switch viewDisplay {
        case "ShareView":
            ShareView()
        case "AccountView":
            UserProfileView()
        default:
            MoreView()
        }
    }
}

#Preview {
    MoreView()
}

struct MoreItem: Hashable{
    let mainText: String
    let subText: String
    let viewDisplay: String
}
