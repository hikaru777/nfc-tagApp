import SwiftUI
import Kingfisher
import FirebaseAuth
import UIKit
import PhotosUI


extension UIView {
    func snapshot() -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: bounds.size)
        let image = renderer.image { context in
            layer.render(in: context.cgContext)
        }
        return image
    }
}

struct ContentView: View, SendProfileOKDelegate {
    
    @StateObject var viewModel: WriteIntoNFCViewModel
    @State var isPresented: Bool = false
    
    var body: some View {
        VStack(spacing: 15) {
            
            VStack(alignment: .leading, spacing: 10) {
                
                Text("Your profile")
                    .foregroundStyle(.white)
                    .font(.title)
                    .bold()
                
                if viewModel.decidedProfileImageUrl != "" {
                    
                    KFImage(URL(string: viewModel.decidedProfileImageUrl))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 310, height: 550)
                        .background(Color.white)
                        .cornerRadius(21)
                        .onTapGesture {
                            viewModel.opacity = 100
                            isPresented = true
                        }
                    
                } else {
                    Image("Image 1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 310, height: 550)
                        .background(Color.white)
                        .cornerRadius(21)
                        .onTapGesture {
                            viewModel.opacity = 100
                            isPresented = true
                        }
                }
                
            }
            
            Button(action: {
                NFCManager.shared.write(text: viewModel.uid)
            }) {
                Text("書き込む")
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
            }
            .padding(.bottom, 40)
            .fullScreenCover(isPresented: $isPresented) {
                NextView(viewModel: viewModel)
            }
            .presentationBackground(Material.ultraThinMaterial)
        }
        .ignoresSafeArea(.all)
        .onAppear {
            Task {
                do {
                    if let uid = Auth.auth().currentUser?.uid {
                        viewModel.uid = uid
                        let data = try await FirebaseClient.getProfileViewData(uid: Auth.auth().currentUser!.uid)
                        viewModel.decidedProfileImageUrl = data.imageUrl
                    }
                    let checkModel = CheckPermission()
                    checkModel.showCheckPerission()
                    viewModel.sendToDBModel.sendProfileOKelegate = self
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func sendProfileOKDelegate(url: String) {
        viewModel.decidedProfileImageUrl = url
        if viewModel.imageUrl == nil {
            print("enpty")
        }
    }
    
}

