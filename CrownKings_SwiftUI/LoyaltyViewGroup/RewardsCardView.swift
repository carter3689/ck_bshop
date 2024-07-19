//
//  RewardsCardView.swift
//  crownkingsbarbershop
//
//  Created by Joel Carter on 5/24/24.
//

import SwiftUI

struct StorableDate: RawRepresentable {
    let rawValue: String //
    
    init?(rawValue: String){
        guard let date = ISO8601DateFormatter().date(from: rawValue) else { return nil}
        self = StorableDate(date: date)
    }
    
    init(date: Date){
        self.rawValue = ISO8601DateFormatter().string(from: date)
    }
    
    var date: Date {
        ISO8601DateFormatter().date(from: rawValue)!
    }
}

struct RewardsCardView: View {
    let rewardPhoto: String
    var rewardText: String
    @Binding var rewardRedeemed: Bool
    @Binding var rewardId: Int
    let costOfReward: CGFloat
    
    @AppStorage("buttonLastClicked") var buttonLastClicked: StorableDate?
    
//    let _currentPoints: CGFloat
    
    @EnvironmentObject private var loyaltyViewModel: LoyaltyViewModel
    @EnvironmentObject var viewModel: AuthenticationViewModel
    @EnvironmentObject var rewardViewModel: RewardViewModel
    
    func redeemReward(rewardId: Int, costOfReward: CGFloat, currentPoints: CGFloat) {
        if (rewardId == 1 && costOfReward <= currentPoints){
            rewardRedeemed.toggle()
        } else if (rewardId == 2 && costOfReward <= currentPoints){
            rewardRedeemed.toggle()
            print("reward 2")
            print(loyaltyViewModel.currentPoints)
        } else {
            print("Error: Insuffient Points.")
        }
    }
    
    func canClickButton() -> Bool {
        guard let lastClick = buttonLastClicked?.date else { return true}
        
        let calendar = Calendar.current
        let oneMonthLater = calendar.date(byAdding: .month, value: 1, to:lastClick)!
        return Date() >= oneMonthLater // Check if month has passed
    }
    
    var body: some View {
        HStack{
            ZStack{
                Image(rewardPhoto) // Add your image here
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 225)
                    .cornerRadius(15)
                    .padding()
                VStack(spacing:0){
                    Spacer()
                    ZStack{
                        GeometryReader { geo in
                            Color.black.opacity(0.5)
                                .cornerRadius(12)
                                .frame(width: geo.size.width - 32, height: geo.size.height)
                                .padding(.horizontal)
                                .offset(y:13)
                        }
                        VStack(spacing:10){
                            Spacer()
                            Text(
                                rewardText
                            )
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.horizontal)
                            if (loyaltyViewModel.currentPoints < costOfReward){
                                Text("Not enough points to redeem")
                                    .font(.callout)
                                    .foregroundStyle(Color.white)
                                    .padding(.horizontal)
                            }
                            Spacer()
                            Text(costOfReward.description)
                                .font(.callout)
                                .foregroundStyle(.white)
                                .padding(.horizontal)
                            
                            Button(action: {
                                redeemReward(rewardId: rewardId, costOfReward: costOfReward, currentPoints: loyaltyViewModel.currentPoints)
                                if canClickButton() {
                                    buttonLastClicked = StorableDate(date: Date())
                                }
                            }, label: {
                                Text(rewardRedeemed ? "Redeemed" : "Redeem")
                                    .frame(maxWidth: .infinity)
                                    .opacity(rewardRedeemed ? 0.7 : 1.0)
                                    .padding()
                                    .background(
                                        Capsule()
                                            .foregroundColor(.white)
                                    )
                            })
                            .buttonStyle(.plain)
                            .disabled(rewardRedeemed || !canClickButton())
                            .opacity(rewardRedeemed ? 0.5 : 1.0)
                            .padding(.horizontal)
                            .padding(.bottom)
                        }
                    }
                    
                }.padding(.bottom)
                    .offset(y:-10)
            }
        }
    }
}

//#Preview {
//    RewardsCardView(rewardPhoto:"crown_kings_main_photo", rewardText: "10% off next haircut", rewardRedeemed: false, currentPoints: currentPoints)
//}
