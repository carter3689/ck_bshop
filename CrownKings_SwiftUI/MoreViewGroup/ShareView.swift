//
//  ShareView.swift
//  crownkingsbarbershop
//
//  Created by Joel Carter on 5/22/24.
//

import SwiftUI

struct ShareView: View {
    var body: some View {
        VStack {
            ShareLink(item: URL(string: "https://www.crownkingsbarbershop.com/")!) {
                Label("Share", systemImage: "square.and.arrow.up")
                    .font(.largeTitle)
            }
            Text("Share your cut with friends!")
        }
        .navigationTitle("Share")
    }
}

#Preview {
    ShareView()
}
