//
//  VideosView.swift
//  crownkingsbarbershop
//
//  Created by Joel Carter on 5/21/24.
//

import SwiftUI
import _PhotosUI_SwiftUI
import AVKit

struct VideosView: View {
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
        NavigationStack{
            ScrollView{
                ForEach(viewModel.videos) { video in
                    VideoPlayer(player: AVPlayer(url: URL(string: video.videoUrl)!))
                        .frame(height: 250)
                }
            }
            .refreshable {
                Task {
                    try await viewModel.fetchVideos()
                }
            }
            .navigationTitle("Videos")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    PhotosPicker(selection: $viewModel.selectedItem, matching: .any(of: [.videos, .not(.images)])) {
                        Image(systemName: "plus")
                            .foregroundColor(.black)
                    }
                }
            }
            .padding()
        }
    }
}



#Preview {
    VideosView()
}
