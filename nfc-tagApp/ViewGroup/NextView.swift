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
                            .frame(width: 30, height: 30)
                            .foregroundStyle(.white, .gray)
                    }

                    Spacer()

                }
                .padding(.leading, 40)
                .padding(.top, 10)
                .opacity(Double(viewModel.opacity))

                //名前の文字数を取得したいけどわからなかった
                //                VStack {
                //                    TextField("Enter text", text: $ininputText)
                //                        .textFieldStyle(RoundedBorderTextFieldStyle())
                //                        .padding()
                //
                //                    Text("Character Count: \($inputText.count)")
                //                        .padding()
                //                }

                TextField("名前！", text: $name)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
                    .font(.system(size: 30.0))
                    .textFieldStyle(.roundedBorder)
                    .multilineTextAlignment(TextAlignment.center)

                HStack{
                    Text("あ")
                        .font(Font.custom("Anonymous Pro", size: 30))
                        .multilineTextAlignment(.trailing)
                        .foregroundColor(Color(red: 0.18, green: 0.18, blue: 0.18))
                        .rotationEffect(Angle(degrees: -16))

                    Text("お")
                        .font(Font.custom("Anonymous Pro", size: 30))
                        .multilineTextAlignment(.trailing)
                        .foregroundColor(Color(red: 0.18, green: 0.18, blue: 0.18))
                        .rotationEffect(Angle(degrees: -0.37))
                        .padding(.top, -10)

                    Text("ば")
                        .font(Font.custom("Anonymous Pro", size: 30))
                        .multilineTextAlignment(.trailing)
                        .foregroundColor(Color(red: 0.18, green: 0.18, blue: 0.18))
                        .rotationEffect(Angle(degrees: 16))
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
                            .overlay(Circle().stroke(Color.gray, lineWidth: 4))
                            .shadow(color: .gray.opacity(0.5), radius: 13, x: 0, y: 0)
                            .padding(.top, -50)
                    }
                } else {
                    Button {
                        showImagePickerView.toggle()
                    } label: {
                        KFImage(viewModel.imageUrl)
                            .resizable()
                        //                            .scaledToFill()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100)
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
                                //                                Image("WebD")
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
                        Text(" \(selectedOption)")
                    }
                }

                Image("Line 3")
                    .frame(width: 400, height: 0.5)
                    .padding(.top, 16)

                TextEditor(text: $editorText)
                    .frame(width: 320, height: 240)
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
                //何も入力されていない時に、入力補助をしたかったけどわからん
                //                    .overlay(alignment: .topLeading) {
                //
                //                        if inputText.isEmpty {
                //                            Text("Please enter some text.")
                //                                .foregroundColor(.red)
                //                        } else {
                //                            Text("Text entered: \(inputText)")
                //                        }
                //                    }

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

                        //                        let maskColor:[CGFloat] = [255, 255, 255, 255, 255, 255]
                        //
                        //                        let withoutWhiteImage = changeColorByTransparent(imgView: viewModel.capturedImage!, cMask: maskColor)

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

