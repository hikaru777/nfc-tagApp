//
//  LoadInNFC.swift
//  wed-nfc
//
//  Created by 本田輝 on 2024/01/24.
//

import SwiftUI
import Kingfisher
import FirebaseAuth

//読み込み画面
struct LoadIntoNFC: View {
    
    @ObservedObject var viewModel: ReadIntoNFCViewModel
    
    var body: some View {
        
        VStack(spacing: 15) {
            
            if viewModel.imageUrl != "" {
                
                KFImage(URL(string: viewModel.imageUrl))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 310, height: 550)
                    .background(Color.white)
                    .cornerRadius(21)
                
            }
            Button(action: {
                NFCManager.shared.read { text in
                    if let text = text {
                        viewModel.textLabel = text
                        Task {
                            do {
                                let data = try await FirebaseClient.getProfileViewData(uid: text)
                                viewModel.imageUrl = data.imageUrl
                                print(text)
                                if !viewModel.profileData.gotAccounts!.contains(text) {
                                    viewModel.profileData.gotAccounts!.append(text)
                                }
                                print(viewModel.profileData.gotAccounts)
                                try await FirebaseClient.setImage(uid: Auth.auth().currentUser!.uid, imageUrl: viewModel.profileData!)
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                    } else {
                        viewModel.textLabel = "データなし"
                    }
                }
            }, label: {
                Text("読み込む")
                    .fontWeight(.semibold)
                    .frame(width: 160, height: 48)
                    .foregroundColor(Color(.blue))
                    .background(Color(.white))
                    .cornerRadius(24)
                    .overlay(
                        RoundedRectangle(cornerRadius: 24)
                            .stroke(Color(.blue), lineWidth: 1.0)
                            .foregroundColor(Color.black)
                            .bold()
                            .font(.title)
                    )
            })

            .onAppear {
                Task {
                    do {
                        viewModel.profileData = try await FirebaseClient.getProfileViewData(uid: Auth.auth().currentUser!.uid)
                        
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            
        }
    }
}
