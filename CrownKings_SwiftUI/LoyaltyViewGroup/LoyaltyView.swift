//
//  LoyaltyView.swift
//  CrownKings_SwiftUI
//
//  Created by Joel Carter on 5/8/24.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct RewardLoyalty: Identifiable, Codable,Hashable {
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
    
    static func == (lhs: RewardLoyalty, rhs: RewardLoyalty) -> Bool {
        lhs.id == rhs.id
    }
}



struct LoyaltyView: View {

    
    @State var _color = Color(#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1))
    @State var _color2 = Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))

    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    @EnvironmentObject private var loyaltyViewModel : LoyaltyViewModel
    @EnvironmentObject var rewardsViewModel: RewardViewModel
    
    @Environment(\.colorScheme) var colorScheme
    
    @State var rewardRedeemed: [Bool] = [false,false]
    @State var rewardId: [Int] = [1,2]
    
    var body: some View {
        AuthenticatedView {
            
        } content: {
            NavigationStack{
                VStack{
                    ZStack{
                        RoundedRectangle(cornerRadius: 5.0)
                            .frame(width:377, height: 225)
                            .offset(y:12)
                        HStack{
                            Text("Welcome")
                                .foregroundColor(colorScheme == .dark ? .black : .white)
                                .offset(x:-64, y:-55)
                                .font(.title)
                            ZStack{
                                Text("\(Int(loyaltyViewModel.currentPoints)) Points")
                                    .foregroundStyle(colorScheme == .dark ? .black : .white)
                                    .font(.title)
                            }.offset(x:65, y:-55)
                        }.offset(y:-25)
                        LazyVGrid (columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible()),
                        ], spacing: 16, content:{
                            RewardProgressCard(title: $loyaltyViewModel.title, _currentProgress: $loyaltyViewModel._currentProgress, _totalProgress: $loyaltyViewModel._totalProgress, percent: $loyaltyViewModel.percent)
                                .frame(width:171, height: 175)
                                .offset(x:95,y:25)
                                .animation(.spring(), value: loyaltyViewModel.percent)
                        })
                        
                    }
                Spacer()
                    Button(action: {
                        loyaltyViewModel.showSheet.toggle()
                    }) {
                        Image(systemName: "plus")
                        Text("Get Stamp")
                            .foregroundStyle(colorScheme == .dark ? .white : .white)
                    }
                    .buttonStyle(.borderedProminent)
                    .offset(x:-105, y:-25)
                    .padding(.horizontal)
                    
                    .sheet(isPresented: $loyaltyViewModel.showSheet) {
                        LazyVGrid(columns: [
                            GridItem(.flexible()),
                        ], spacing: 16, content: {
                            Button(action: {
                                loyaltyViewModel._currentProgress += 1
                                loyaltyViewModel.percent += 10
                                loyaltyViewModel.currentPoints += 10
                                print("From: LoyaltyView: \(loyaltyViewModel.currentPoints)")
                                
                                //Create Task to call async function
                                Task{
                                    await loyaltyViewModel.savePoints()
                                }
                            }, label: {
                                Text("Stamp")
                            })
                            .buttonStyle(.borderedProminent)
                        })
                    }
                }.navigationTitle("Loyalty")
                    .toolbarBackground(Color.black, for: .navigationBar)
                    .toolbarBackground(.visible, for: .navigationBar)
                    .toolbarColorScheme(.dark)
                
            }
        }
        .onAppear {
            switch viewModel.authenticationState {
            case .unauthenticated:
                loyaltyViewModel.resetPoints()
                
            case .authenticated:
                loyaltyViewModel.updateProgressForSignedInUser(response: viewModel.user?.uid)
                
            default:
                print("Please authenticate user")

            }
        }
    }
}

