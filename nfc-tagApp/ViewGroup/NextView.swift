//
//  NextView.swift
//  nfc-tagApp
//
//  Created by 本田輝 on 2024/02/05.
//

import SwiftUI
import FirebaseAuth
import Kingfisher

//マイプロフィールのView
struct NextView: View, SendProfileOKDelegate {

    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: WriteIntoNFCViewModel
    @State var image: UIImage?
    @State var showImagePickerView = false
    @State var name: String = ""

    //    @State private var isTextFieldVisible = true

    @State var ininputText: String = ""
    @State private var showOptions: Bool = false
    @State private var selectedOption: String?
    @State var editorText: String = ""
    @FocusState var focus: Bool

    var body: some View {

        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)

            VStack {

                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "x.circle.fill")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundStyle(.white, .gray)
                    }

                    Spacer()

                }
                .padding(.leading, 40)
                .padding(.top, 10)
                .opacity(Double(viewModel.opacity))

                //                if isTextFieldVisible {
                TextField("名前！", text: $name)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
                    .font(.system(size: 30.0))
                    .textFieldStyle(.roundedBorder)
                    .multilineTextAlignment(TextAlignment.center)
                //                    .onChange(of: name) { newValue in
                //                        if !newValue.isEmpty {
                //                            isTextFieldVisible = false
                //                        }
                //                    }
                //                }

                switch name.count {
                case 1:
                    HStack{
                        Text(String(name[name.index(name.startIndex, offsetBy: 0)]))
                            .font(Font.custom("SF Pro", size: 30))
                            .multilineTextAlignment(.trailing)
                            .foregroundColor(Color(red: 0.18, green: 0.18, blue: 0.18))
                    }
                    .padding(.bottom, -4)

                case 2:
                    HStack{
                        Text(String(name[name.index(name.startIndex, offsetBy: 0)]))
                            .font(Font.custom("SF Pro", size: 30))
                            .multilineTextAlignment(.trailing)
                            .foregroundColor(Color(red: 0.18, green: 0.18, blue: 0.18))
                            .rotationEffect(Angle(degrees: -6))

                        Text(String(name[name.index(name.startIndex, offsetBy: 1)]))
                            .font(Font.custom("SF Pro", size: 30))
                            .multilineTextAlignment(.trailing)
                            .foregroundColor(Color(red: 0.18, green: 0.18, blue: 0.18))
                            .rotationEffect(Angle(degrees: 6))
                    }
                    .padding(.bottom, -4)

                case 3:
                    HStack{
                        Text(String(name[name.index(name.startIndex, offsetBy: 0)]))
                            .font(Font.custom("SF Pro", size: 30))
                            .multilineTextAlignment(.trailing)
                            .foregroundColor(Color(red: 0.18, green: 0.18, blue: 0.18))
                            .rotationEffect(Angle(degrees: -18))
                            .padding(.trailing, -4)

                        Text(String(name[name.index(name.startIndex, offsetBy: 1)]))
                            .font(Font.custom("SF Pro", size: 30))
                            .multilineTextAlignment(.trailing)
                            .foregroundColor(Color(red: 0.18, green: 0.18, blue: 0.18))
                            .rotationEffect(Angle(degrees: 0))
                            .padding(.top, -10)

                        Text(String(name[name.index(name.startIndex, offsetBy: 2)]))
                            .font(Font.custom("SF Pro", size: 30))
                            .multilineTextAlignment(.trailing)
                            .foregroundColor(Color(red: 0.18, green: 0.18, blue: 0.18))
                            .rotationEffect(Angle(degrees: 18))
                            .padding(.leading, -4)
                    }
                    .padding(.bottom, -6)

                case 4:
                    HStack{
                        Text(String(name[name.index(name.startIndex, offsetBy: 0)]))
                            .font(Font.custom("SF Pro", size: 26))
                            .multilineTextAlignment(.trailing)
                            .foregroundColor(Color(red: 0.18, green: 0.18, blue: 0.18))
                            .rotationEffect(Angle(degrees: -30))
                            .padding(.trailing, -4)

                        Text(String(name[name.index(name.startIndex, offsetBy: 1)]))
                            .font(Font.custom("SF Pro", size: 26))
                            .multilineTextAlignment(.trailing)
                            .foregroundColor(Color(red: 0.18, green: 0.18, blue: 0.18))
                            .rotationEffect(Angle(degrees: -9))
                            .padding(.top, -24)

                        Text(String(name[name.index(name.startIndex, offsetBy: 2)]))
                            .font(Font.custom("SF Pro", size: 26))
                            .multilineTextAlignment(.trailing)
                            .foregroundColor(Color(red: 0.18, green: 0.18, blue: 0.18))
                            .rotationEffect(Angle(degrees: 9))
                            .padding(.top, -24)

                        Text(String(name[name.index(name.startIndex, offsetBy: 3)]))
                            .font(Font.custom("SF Pro", size: 26))
                            .multilineTextAlignment(.trailing)
                            .foregroundColor(Color(red: 0.18, green: 0.18, blue: 0.18))
                            .rotationEffect(Angle(degrees: 30))
                            .padding(.leading, -4)
                    }
                    .padding(.bottom, -14)

                case 5:
                    HStack{
                        Text(String(name[name.index(name.startIndex, offsetBy: 0)]))
                            .font(Font.custom("SF Pro", size: 26))
                            .multilineTextAlignment(.trailing)
                            .foregroundColor(Color(red: 0.18, green: 0.18, blue: 0.18))
                            .rotationEffect(Angle(degrees: -42))
                            .padding(.trailing, -10)

                        Text(String(name[name.index(name.startIndex, offsetBy: 1)]))
                            .font(Font.custom("SF Pro", size: 26))
                            .multilineTextAlignment(.trailing)
                            .foregroundColor(Color(red: 0.18, green: 0.18, blue: 0.18))
                            .rotationEffect(Angle(degrees: -22))
                            .padding(.top, -32)
                            .padding(.trailing, -6)

                        Text(String(name[name.index(name.startIndex, offsetBy: 2)]))
                            .font(Font.custom("SF Pro", size: 26))
                            .multilineTextAlignment(.trailing)
                            .foregroundColor(Color(red: 0.18, green: 0.18, blue: 0.18))
                            .rotationEffect(Angle(degrees: 0))
                            .padding(.top, -38)

                        Text(String(name[name.index(name.startIndex, offsetBy: 3)]))
                            .font(Font.custom("SF Pro", size: 26))
                            .multilineTextAlignment(.trailing)
                            .foregroundColor(Color(red: 0.18, green: 0.18, blue: 0.18))
                            .rotationEffect(Angle(degrees: 22))
                            .padding(.top, -32)
                            .padding(.leading, -6)

                        Text(String(name[name.index(name.startIndex, offsetBy: 4)]))
                            .font(Font.custom("SF Pro", size: 26))
                            .multilineTextAlignment(.trailing)
                            .foregroundColor(Color(red: 0.18, green: 0.18, blue: 0.18))
                            .rotationEffect(Angle(degrees: 42))
                            .padding(.leading, -10)
                    }
                    .padding(.bottom, -26)

                default:
                    EmptyView()

                }

                if viewModel.imageUrl == URL(string: "") {

                    Button {
                        showImagePickerView.toggle()
                    } label: {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 300)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 1))
                            .shadow(color: .gray.opacity(0.5), radius: 13, x: 0, y: 0)
                            .padding(.top, -50)
                    }
                } else {
                    Button {
                        showImagePickerView.toggle()
                    } label: {
                        KFImage(viewModel.imageUrl)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 160)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                            .shadow(color: .gray.opacity(0.5), radius: 13, x: 0, y: 0)
                    }
                }

                //ボタンを押すと選択肢を表示
                VStack {
                    Button(action: {
                        self.showOptions.toggle()
                    }) {
                        Text("コースを選択")
                            .padding(.all, 6)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .font(Font.custom("SF Pro", size: 12))
                    }

                    if showOptions {
                        VStack {
                            Text("君のコースは")
                            Button(action: {
                                self.selectedOption = "WebD"
                                self.showOptions.toggle()
                            }) {
                                Text("WebD")
                            }
                            Button(action: {
                                self.selectedOption = "iPhone"
                                self.showOptions.toggle()
                            }) {
                                Text("iPhone")
                            }
                            Button(action: {
                                self.selectedOption = "Unity"
                                self.showOptions.toggle()
                            }) {
                                Text("Unity")
                            }
                        }

                    }

                    if let selectedOption = selectedOption {
                        Image("\(selectedOption)")
                            .frame(width: 50, height: 50)
                    }
                }

                Image("Line 3")
                    .frame(width: 400, height: 0.5)
                    .padding(.top, 16)

                TextEditor(text: $editorText)
                    .frame(width: 320, height: 200)
                    .scrollContentBackground(.hidden)
                    .background(.white, in: RoundedRectangle(cornerRadius: 30.0))
                    .padding()
                    .multilineTextAlignment(.center)
                    .shadow(color: .gray.opacity(0.2), radius: 13, x: 0, y: 0)
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    .padding(.bottom, 10)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .focused($focus)
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()
                            Button("閉じる") {
                                focus = false
                            }
                        }
                    }


                Button(action: {
                    UserDefaults.standard.set(name, forKey: "name")
                    UserDefaults.standard.set(editorText, forKey: "editorText")
                    viewModel.opacity = 0
                    viewModel.showXButton = true

                }) {
                    Text("保存する")
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
                        .padding(.top, 20)
                }
                .disabled(viewModel.showXButton)
                .opacity(Double(viewModel.opacity))
            }
        }

        .sheet(isPresented: $showImagePickerView) {
            ImagePickerView(image: $image, sourceType: .library, allowsEditing: true)
                .ignoresSafeArea(.all)
        }

        .onAppear {
            viewModel.showXButton = false
            name = UserDefaults.standard.string(forKey: "name") ?? ""
            editorText = UserDefaults.standard.string(forKey: "editorText") ?? ""
            viewModel.imageUrl = UserDefaults.standard.url(forKey: "userImage")
            let checkModel = CheckPermission()
            checkModel.showCheckPerission()
            viewModel.sendToDBModel.sendProfileOKelegate = self
        }

        .onChange(of: image) {
            Task {
                viewModel.imageUrl = await viewModel.sendToDBModel.uploadProfileImage(image: image!)!
            }
        }

        .onChange(of: viewModel.opacity) {

            let interval: TimeInterval = 1
            DispatchQueue.main.asyncAfter(deadline: .now() + interval, execute: {

                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let image = windowScene.windows.first?.snapshot() {
                    viewModel.capturedImage = image
                    saveImageToPhotos(image)
                }

                Task {

                    do {
                        let data = try await FirebaseClient.getProfileViewData(uid: Auth.auth().currentUser!.uid)

                        let imageUrl = await viewModel.sendToDBModel.uploadProfileViewImage(image: viewModel.capturedImage!)
                        try await FirebaseClient.setImage(uid: Auth.auth().currentUser!.uid, imageUrl: ImageData(imageUrl: imageUrl!.cacheKey, gotAccounts: data.gotAccounts ))
                        viewModel.decidedProfileImageUrl = imageUrl!.cacheKey

                        dismiss()
                    } catch {
                        print(error.localizedDescription)
                    }

                }
            })
        }
    }

    // 画像をフォトライブラリに保存するメソッド
    private func saveImageToPhotos(_ image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }

    func changeColorByTransparent(imgView: UIImage, cMask: [CGFloat]) -> UIImage? {
        var returnImage: UIImage?
        let sz = imgView.size

        UIGraphicsBeginImageContextWithOptions(sz, true, 0.0)
        imgView.draw(in: CGRect(origin: CGPoint.zero, size: sz))
        let noAlphaImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        let noAlphaCGRef = noAlphaImage?.cgImage
        if let imgRefCopy = noAlphaCGRef?.copy(maskingColorComponents: cMask) {
            returnImage = UIImage(cgImage: imgRefCopy)
        }


        return returnImage

    }

    func sendProfileOKDelegate(url: String) {
        viewModel.imageUrl = URL(string: url)!
        if viewModel.imageUrl == nil {
            print("enpty")
        }
    }
}

