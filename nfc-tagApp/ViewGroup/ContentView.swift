import SwiftUI
import GameplayKit
import Kingfisher
import FirebaseAuth
import UIKit
import PhotosUI

//マイプロフィール画面
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
    @State var voronoi: Image!
    @StateObject var lenticulationManager = LenticulationManager()
    @State var offset: Float = 0
    
    var body: some View {
        VStack(spacing: 15) {
            
            VStack(alignment: .leading, spacing: 10) {
                
                Text("Your profile")
                    .foregroundStyle(.white)
                    .font(.title)
                    .bold()
                
                if viewModel.decidedProfileImageUrl != "" {
                    
                    ZStack {
                        //                        Image("back")
                        //                            .resizable()
                        //                            .ignoresSafeArea()
                        //                            .scaledToFit()
                        
                        KFImage(URL(string: viewModel.decidedProfileImageUrl))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 500)
                            .background(Color.white)
                            .cornerRadius(21)
                            .aspectRatio(contentMode: .fit)
                            .onTapGesture {
                                viewModel.opacity = 100
                                isPresented = true
                            }
                        
//                        Image("front")
//                            .resizable()
                        KFImage(URL(string: viewModel.decidedProfileImageUrl))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 500)
                            .background(Color.white)
                            .cornerRadius(21)
                            .aspectRatio(contentMode: .fit)
                            .colorEffect(ShaderLibrary.holographic(.image(voronoi), .float(lenticulationManager.frontImageOpacitry > 0 ? lenticulationManager.frontImageOpacitry : -lenticulationManager.middleImageOpacity)))
                            .opacity(lenticulationManager.frontImageOpacitry > 0 ? lenticulationManager.frontImageOpacitry + 0.5 : lenticulationManager.middleImageOpacity + 0.5)
                    }
                    
                } else {
                    Image("Image 1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 500)
                        .background(Color.white)
                        .cornerRadius(21)
                        .onTapGesture {
                            viewModel.opacity = 100
                            isPresented = true
                        }
                }
                
            }
//            .onChange(of: lenticulationManager.frontImageOpacitry) {
//                voronoi = makeVoronoi()
//            }
            .onAppear(perform: {
                voronoi = makeVoronoi()
            })
            
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
    
    func makeVoronoi() -> Image {
        let voronoiNoiseSource = GKVoronoiNoiseSource(frequency: 20, displacement: 1, distanceEnabled: false, seed: 555)
        let noise = GKNoise(voronoiNoiseSource)
        let noiseMap = GKNoiseMap(noise, size: .init(x: 1, y: 1), origin: .zero, sampleCount: .init(x: 900, y: 1500), seamless: true)
        let texture = SKTexture(noiseMap: noiseMap)
        let cgImage = texture.cgImage()
        return Image(cgImage, scale: 1, label: Text(""))
    }

    func sendProfileOKDelegate(url: String) {
        viewModel.decidedProfileImageUrl = url
        if viewModel.imageUrl == nil {
            print("enpty")
        }
    }

}

