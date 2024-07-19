//
//  RewardCardView.swift
//  crownkingsbarbershop
//
//  Created by Joel Carter on 5/23/24.
//

import SwiftUI
import FirebaseFirestore



struct RewardProgressCard: View {
//    let title: String // Title of the reward/streak
//    var currentProgress: Int // Current progress amount
//    let totalProgress: Int // Total progress needed

    @Binding var title: String
    @Binding var _currentProgress: Int
    @Binding var _totalProgress:Int
    @Binding var percent: CGFloat

 

    var _color = Color(#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1))
    var _color2 = Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
    
    @State private var animatedProgress: Float = 0 // Added state for animation

    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    @Environment(\.colorScheme) var colorScheme
    
    @StateObject private var loyaltyViewModel = LoyaltyViewModel()
    
    func redeemReward() async {
        guard let userId = viewModel.user?.uid else {return}
        
        let db = Firestore.firestore()
        let userProgressRef = db.collection("userPoints").document(userId)
        
        do {
            try await userProgressRef.updateData([
                "_currentProgress": 0,
                "percent": 0
            ])
            // Update local state to reflect changes
            _currentProgress = 0
            percent = 0
        } catch {
            print("Error redeeming reward: \(error.localizedDescription)")
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            VStack {
                Button("25% off") 
                {
                    // Action when button is tapped (e.g. claim reward)
                    Task{
                        await redeemReward()
                    }
                    print("currentProgress: \(_currentProgress)")
                }
                .disabled( _currentProgress < _totalProgress)
                .buttonStyle(.borderedProminent)
                .foregroundStyle(colorScheme == .dark ? .black : .white)
                HStack {
                    Text(title)
                        .font(.headline) //Style the title
                        .foregroundStyle(colorScheme == .dark ? .black : .black)
                    Spacer()
                }
            }
            ProgressBar(width:300, height:40, percent: percent, color1: _color, color2: _color2)
            Text("\(_currentProgress) of \(_totalProgress)")
                .font(.caption)
                .foregroundColor(colorScheme == .dark ? .black : .secondary)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .shadow(radius: 12)
        )
    }
}


//struct RewardCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        RewardProgressCard(title:"Monthly Loyalty Streak", currentProgress: 3, totalProgress: 7, percent: Binding<CGFloat> )
//    }
//}
