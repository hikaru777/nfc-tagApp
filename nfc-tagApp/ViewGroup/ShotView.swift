//
//  ShotView.swift
//  nfc-tagApp
//
//  Created by 本田輝 on 2024/02/05.
//

import SwiftUI
import Kingfisher

struct ShotView: View {
    
    @State var name: String
    @State var editorText: String
    @State var imageUrl: URL
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            VStack {
                
                // ここに画面を作る
                
                TextField("名前！", text: $name)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
                    .textFieldStyle(.roundedBorder)
                
                
                    KFImage(imageUrl)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.gray, lineWidth: 4))
                        .shadow(color: .gray, radius: 10, x: 10, y: 10)
                        .padding(.top, -50)
                
                
                
                Text("自己紹介")
                    .font(.system(.title,design:.monospaced))
                    .fontWeight(.black)
                    .font(.title)
                    .foregroundColor(.gray)
                    .padding(.top, 20)
                
                TextEditor(text: $editorText)
                    .frame(width: 320, height: 320)
                    .scrollContentBackground(.hidden)
                    .background(.white, in: RoundedRectangle(cornerRadius: 30.0))
                    .padding()
                    .multilineTextAlignment(.center)
                    .shadow(color: .gray, radius: 10, x: 0, y: 0)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                
                
            }
        }
    }
}
