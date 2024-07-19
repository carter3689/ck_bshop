////
////  Rewards.swift
////  crownkingsbarbershop
////
////  Created by Joel Carter on 6/23/24.
////
//
//import Foundation
//
//
//func randomString(length: Int) -> String {
//  let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
//  return String((0..<length).map{ _ in letters.randomElement()! })
//}
//
//struct Reward: Identifiable, Decodable {
//    let id: String
//    let rewardsName: String
//    let rewardPointsNeeded: CGFloat
//    let percent: CGFloat
//    let _currentProgress: Int
//    let _totalProgress: Int
//    let _percent: CGFloat
//    let rewardRedeemed:Bool
//    let rewardPhoto:String
//}
//
//struct RewardResponse: Decodable {
//    let request: [Reward]
//}
//
//struct MockData {
//    static let rewards = [sampleReward, sampleReward]
//    
//    static let sampleReward = Reward(
//      id: randomString(length: 256), // Correct ID initialization
//      rewardsName: "Sample Reward",
//      rewardPointsNeeded: 100,
//      percent: 0.5, // Assuming 50% completion
//      _currentProgress: 50,
//      _totalProgress: 100,
//      _percent: 50,
//      rewardRedeemed: false,
//      rewardPhoto: "sample_reward_photo"
//    )
//  }
