//
//  LoyaltyViewModel.swift
//  crownkingsbarbershop
//
//  Created by Joel Carter on 6/23/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class LoyaltyViewModel: ObservableObject {
    
    @Published var title: String = "Monthly Loyalty Streak"
    @Published  var percent: CGFloat = 0
    @Published var showSheet: Bool = false
    @Published var _currentProgress: Int = 0
    @Published var _totalProgress: Int = 10
    @Published var currentPoints: CGFloat = 0
    @Published var pointTotal: CGFloat = 0
    
    
    func savePoints() async {
        
        // Check if a user is authenticated
        guard let user = Auth.auth().currentUser else {
            print("Error: No user is currently authenticated")
            return // Exit the function if no user is logged in
        }
        
        let db = Firestore.firestore()
        // Use the authenticated user's UID as the documentID
        let documentRef = db.collection("userPoints").document(user.uid)
        
        let dataToUpdate: [String:Any] = [
            "currentPoints": currentPoints,
            "percent": percent,
            "_currentProgress": _currentProgress,
            "timestamp": FieldValue.serverTimestamp()
        ]
        
        
        do {
            // Check and update or save the document asynchronously
            let documentSnapshot = try await documentRef.getDocument()
            
            if documentSnapshot.exists {
                // Document exists, update it
                try await documentRef.updateData(dataToUpdate)
                print("Points updated successfully")
            } else {
                // Document doesn't exist, create it
                try await documentRef.setData(dataToUpdate)
                print("Points saved successfully")
            }
        } catch {
            // Handle potential errors during the async operation
            print("Error saving/updating points: \(error.localizedDescription)")
        }
        
        print("\(pointTotal) should be equal to \(percent)")
    }
    
    // Reset Points
    func resetPoints() {
        _currentProgress = 0
        currentPoints = 0
        percent = 0
    }
    
    //Update Progress For Signed In user
    func updateProgressForSignedInUser(response:String?) {
        guard let userId = response else { return }
        
        let db = Firestore.firestore()
        let userProgressRef = db.collection("userPoints").document(userId)
        
        userProgressRef.getDocument { (document, error ) in
            if let document = document, document.exists {
                // Update the state variables with data from Firestore
                self._currentProgress = document.get("_currentProgress") as? Int ?? 0
                self.currentPoints = document.get("currentPoints") as? CGFloat ?? 0
                self.percent = document.get("percent") as? CGFloat ?? 0
            } else if let error = error {
                print("Error fetching user progress: \(error.localizedDescription)")
            }
        }
    }
}
