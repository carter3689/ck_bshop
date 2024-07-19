////
////  VideoViewModel.swift
////  crownkingsbarbershop
////
////  Created by Joel Carter on 7/3/24.
////
//
//import Foundation
//import Firebase
//import FirebaseStorage
//import SDWebImageSwiftUI
//import AVFoundation
//
//class VideoViewModel: ObservableObject {
//    @Published var videos: [Video] = []
//    
//    init() {
//        fetchVideos()
//    }
//    
//    func fetchVideos() {
//        let storage = Storage.storage()
//        let videosRef = storage.reference().child("videos") // Path to videos
//        
//        videosRef.listAll { (result, error) in
//            guard error == nil else {
//                print("Error listing videos:", error!)
//                return
//            }
//            
//            for item in result!.items {
//                item.downloadURL { (videoURL, error) in
//                    guard let videoURL = videoURL, error == nil else { return }
//                    
//                    self.generateThumbnail(for: videoURL) { thumbnailURL in
//                        let video = Video(id: item.name, thumbnailURL: thumbnailURL, videoURL: videoURL)
//                        DispatchQueue.main.async {
//                            self.videos.append(video)
//                        }
//                    }
//                }
//            }
//        }
//    }
//}
