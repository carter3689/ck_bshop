//
//  Rewards.swift
//  crownkingsbarbershop
//
//  Created by Joel Carter on 5/21/24.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct RewardsView: View {
    
    
//    var rewardItems: [Reward] = [
//        .init(RewardText: "10% Off Next Haircut", RewardRedeemed: false, rewardPhoto: "crown_kings_main_photo", costOfReward: 10),
//        .init(RewardText: "10% Off Extra Service", RewardRedeemed: true, rewardPhoto: "crown_kings_main_photo", costOfReward: 8),
//        .init(RewardText: "20% Next Haircut", RewardRedeemed: false, rewardPhoto: "crown_kings_main_photo", costOfReward: 15),
//        .init(RewardText: "30% off Next Haircut", RewardRedeemed: false, rewardPhoto: "crown_kings_main_photo", costOfReward: 20),
//        .init(RewardText: "25% Off Next Haircut", RewardRedeemed: true, rewardPhoto: "crown_kings_main_photo", costOfReward: 18),
//        .init(RewardText: "45% Off Next Haircut", RewardRedeemed: true, rewardPhoto: "crown_kings_main_photo", costOfReward: 30)
//    ]
    

    

    @EnvironmentObject private var rewardsViewModel: RewardViewModel
    @EnvironmentObject private var loyaltyViewModel: LoyaltyViewModel
    
    @Binding var rewardRedeemed: Bool
    @Binding var rewardId: Int
    
    @State var rewards: [Reward] = []
    
    func getRewards(currentPoints: CGFloat) async throws -> [Reward]{
        let db = Firestore.firestore()
        let snapshot = try await db.collection("redeemedRewards").getDocuments()
        let rewards = snapshot.documents.compactMap { document ->Reward? in
            guard var reward = try? document.data(as: Reward.self) else { return nil }
            
            //IF rewardsEligible == true AND timesRedeemed == 2
            //rewardRedeemed = true (THIS HAS BEEN REDEEMED)
            if reward.rewardEligible == true && reward.timesRedeemed == 2 {
                reward.rewardRedeemed = true
            }
            
            //IF rewardsEligible == false
            // rewardRedeemed = true
            
            reward.rewardRedeemed = currentPoints >= reward.costOfReward
            
            return reward
        }
        
        return rewards
    }
   
    
    
    var body: some View {
        NavigationStack{
            ScrollView {
                LazyVGrid (columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                ], spacing: 16, content:{
                    ForEach(rewards, id: \.self) { reward in
                        RewardsCardView(rewardPhoto:reward.rewardPhoto, rewardText: reward.rewardText, rewardRedeemed: $rewardRedeemed, rewardId: $rewardId, costOfReward: reward.costOfReward)

                            .environmentObject(loyaltyViewModel)
                        
                    }
                })
            }
            .task {
                    do {
                        let newRewards = try await getRewards(currentPoints: loyaltyViewModel.currentPoints)
                        rewards.append(contentsOf: newRewards)
                    } catch {
                        print("Error Fetching rewards: \(error.localizedDescription)")
                    }
            }
            .navigationTitle("Rewards")
        }
    }
}

//#Preview {
//    RewardsView()
//}

struct Reward: Identifiable, Codable,Hashable {
    @DocumentID var id: String?
    let rewardText: String
    var rewardRedeemed: Bool
    var rewardEligible: Bool
    var timesRedeemed: Int
    let rewardPhoto: String
    let costOfReward: CGFloat
    let timestamp: Timestamp
    let userId: String
    let remainingPoints: CGFloat
}
