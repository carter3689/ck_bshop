//
//  Video.swift
//  crownkingsbarbershop
//
//  Created by Joel Carter on 7/5/24.
//

import Foundation

struct Video: Identifiable, Decodable {
    let videoUrl: String
    var  id: String {
        return NSUUID().uuidString
    }
}
