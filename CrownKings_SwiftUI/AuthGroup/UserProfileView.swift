//
//  UserProfileView.swift
//  crownkingsbarbershop
//
//  Created by Joel Carter on 5/30/24.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct UserProfileView: View {
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    @Environment(\.dismiss) var dismiss
    @State var presentingConfirmationDialog = false
    @State var presentSheet = false
    @State var tempPhone = ""
    
    private func deleteAccount() {
        Task {
            if await viewModel.deleteAccount() == true {
                dismiss()
            }
        }
    }
    
    private func signOut() {
        viewModel.signOut()
    }
    
    func updateUserInfo(tempPhone: String) -> String{
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(Auth.auth().currentUser!.uid)
        
        userRef.updateData([
            "phoneNumber": tempPhone
        ]) { err in
            print(err!.localizedDescription)
        }
        
        return tempPhone
    }
    var body: some View {
        NavigationStack {
            Form{
            Section {
                VStack {
                    HStack {
                        Spacer()
                        Image(systemName: "person.fill")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                            .clipped()
                            .padding(4)
                            .overlay(Circle().stroke(Color.accentColor, lineWidth: 2))
                        Spacer()
                    }
                }
            }
            .listRowBackground(Color(UIColor.systemGroupedBackground))
            Section("You are logged In As:") {
                Text(viewModel.displayName)
            }
            
            Section{
                Button(role: .cancel, action: signOut) {
                    HStack{
                        Spacer()
                        Text("Sign Out")
                        Spacer()
                    }
                }
            }
            Section {
                Button(role: .destructive, action: {
                    presentingConfirmationDialog.toggle()
                }) {
                    HStack{
                        Spacer()
                        Text("Delete Account")
                        Spacer()
                    }
                }
            }
        }.navigationTitle("Profile")
                .navigationBarTitleDisplayMode(.inline)
                   .confirmationDialog("Deleting your account is permanent. Do you want to delete your account?", isPresented: $presentingConfirmationDialog, titleVisibility: .visible) {
                       Button("Delete Account", role: .destructive, action: deleteAccount)
                       Button("Cancel", role: .cancel, action: {})
                   }
         }
        .sheet(isPresented:$presentSheet){
            
        }
    }
}

#Preview {
    UserProfileView()
}
