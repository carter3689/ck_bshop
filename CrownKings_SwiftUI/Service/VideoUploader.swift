//
//  VideoUploader.swift
//  crownkingsbarbershop
//
//  Created by Joel Carter on 7/3/24.
//

import Foundation
import FirebaseStorage
struct VideoUploader {
    static func uploadVideo(withData videoData: Data) async throws -> String? {
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference().child("/videos/\(filename)")
        let metaData = StorageMetadata()
        metaData.contentType = "video/quicktime"
        
        do {
            let _ = try await ref.putDataAsync(videoData, metadata: metaData)
            let url = try await ref.downloadURL()
            return url.absoluteString
        } catch {
            print("DEBUG: Failed to upload video with error \(error.localizedDescription)")
            return nil
        }
    }
}
