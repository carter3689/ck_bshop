//
//  RewardViewModel.swift
//  crownkingsbarbershop
//
//  Created by Joel Carter on 6/23/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class RewardViewModel: ObservableObject{
    @Published var rewardText: String = ""
    @Published var rewardRedeemed: Bool = false
    @Published var rewardPhoto: String = ""
    @Published var costOfReward: CGFloat = 40
    @Published var remainingPoints: CGFloat = 0
    @Published var rewards: [Reward] = []
    
    func redeemPoints(currentPoints: CGFloat) async {
        // Check if a user has been authenticated
        guard let user = Auth.auth().currentUser else {
            print("Error: No user is currently authenticated")
            return
        }

        // Data validation
        guard currentPoints >= costOfReward else {
            print("Error: Insufficient points to redeem the reward.")
            return
        }

        // Firestore transaction
        let db = Firestore.firestore()

        //Redemption Limit Check
        let now = Date()
        let calendar = Calendar.current
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: now))!
        let endOfMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth)!
        
        let query = db.collection("redeemedRewards")
            .whereField("userId", isEqualTo: user.uid)
            .whereField("timestamp", isGreaterThanOrEqualTo: startOfMonth)
            .whereField("timestamp", isLessThanOrEqualTo: endOfMonth)
        
        do {
            let snapshot = try await query.getDocuments()
            if snapshot.documents.count >= 3 {
                print("Error: This reward has already been redeemed 3 times this month")
            return
            }
        } catch {
            print("Error checking redemption history: \(error.localizedDescription)")
        }
        
        let documentRef = db.collection("redeemedRewards").document()

        db.runTransaction { (transaction, errorPointer) -> Any? in
            // Fetch the document
            let documentSnapshot: DocumentSnapshot
            do {
                try documentSnapshot = transaction.getDocument(documentRef)
            } catch let fetchError as NSError {
                errorPointer?.pointee = fetchError
                return nil
            }

            // Check if document exists and get current points
            guard let currentPointsInDocument = documentSnapshot.get("remainingPoints") as? Int else {
                errorPointer?.pointee = NSError(domain: "appDomain", code: -1, userInfo: [
                    NSLocalizedDescriptionKey: "Document missing or remainingPoints field invalid"
                ])
                return nil
            }

            // Ensure enough points and calculate updated points
            guard CGFloat(currentPointsInDocument) >= self.costOfReward else {
                errorPointer?.pointee = NSError(domain: "appDomain", code: -2, userInfo: [
                    NSLocalizedDescriptionKey: "Insufficient points to redeem the reward"
                ])
                // Set rewardRedeemed to false if not enough points available
                
                transaction.updateData(["rewardRedeemed": false], forDocument: documentRef)
                return nil
            }

            let updatedPoints = CGFloat(currentPointsInDocument) - self.costOfReward
            
            // Keep track of remainingPoints State
            self.remainingPoints = updatedPoints

            // Update the document within the transaction
            transaction.updateData(["remainingPoints": updatedPoints], forDocument: documentRef)
            
            
            
            // Return the updated points (optional)
            return updatedPoints
        } completion: { (object, error) in
            if let error = error {
                print("Error redeeming reward: \(error.localizedDescription)")
            } else if let updatedPoints = object as? Int {
                print("Reward redeemed successfully! Updated points: Thanks \(String(describing: user.email)) \(updatedPoints)")
            }
        }
    }
    
    
    func createMultipleRewards(numRewards: Int, userId: String) async {
        let db = Firestore.firestore()
        
        guard let user = Auth.auth().currentUser else {
            print("Error: No user is currently authenticated")
            return
        }

        for _ in 1...numRewards {
            let dataToCreate: [String: Any] = [
                "rewardText": generateRandomRewardText(), // Function to generate random reward text
                "rewardRedeemed": Bool.random(),
                "rewardEligible": Bool.random(),
                "timesRedeemed": Int.random(in: 0...2),
                "rewardPhoto": "crown_kings_main_photo", // Function to generate a random photo URL
                "costOfReward": Int.random(in: 100...1000), // Random cost between 100 and 1000 points
                "timestamp": FieldValue.serverTimestamp(),
                "userId": user.uid,
                "remainingPoints": Int.random(in: 500...5000) // Random initial points
            ]

            do {
                try await db.collection("redeemedRewards").addDocument(data: dataToCreate)
            } catch {
                print("Error creating reward: \(error.localizedDescription)")
            }
        }
    }

    // Helper functions to generate random data
    func generateRandomRewardText() -> String {
        let rewardTypes = ["Discount", "Free Item", "Exclusive Access", "Bonus Points"]
        let randomIndex = Int.random(in: 0..<rewardTypes.count)
        return rewardTypes[randomIndex]
    }

    func generateRandomPhotoURL() -> String {
        // Replace with actual photo URLs from your storage
        let photoURLs = ["https://example.com/reward1.jpg", "https://example.com/reward2.jpg", "https://example.com/reward3.jpg"]
        let randomIndex = Int.random(in: 0..<photoURLs.count)
        return photoURLs[randomIndex]
    }
    
    func getRewards() async throws -> [Reward]{
        let db = Firestore.firestore()
        let snapshot = try await db.collection("redeemRewards").getDocuments()
        let rewards = snapshot.documents.compactMap{try? $0.data(as: Reward.self)}
        
        return rewards
    }
    
    
    struct Reward: Identifiable, Codable,Hashable {
        @DocumentID var id: String?
        let rewardText: String
        let rewardRedeemed: Bool
        let rewardPhoto: String
        let costOfReward: CGFloat
        let timestamp: Timestamp
        let userId: String
        let remainingPoints: CGFloat
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
        
        static func == (lhs: Reward, rhs: Reward) -> Bool {
            lhs.id == rhs.id
        }
    }
    
    
}
