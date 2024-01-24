//
//  LoadInNFC.swift
//  wed-nfc
//
//  Created by 本田輝 on 2024/01/24.
//

import SwiftUI

struct LoadIntoNFC: View {
    
    @StateObject var viewModel: ReadIntoNFCViewModel
    
    var body: some View {
        
        VStack {
            
            Text(viewModel.textLabel)
            
            Button(action: {
                NFCManager.shared.read { text in
                    if let text = text {
                        viewModel.textLabel = text
                    } else {
                        viewModel.textLabel = "データなし"
                    }
                }
            }, label: {
                Text("読み込む")
            })
            
        }
    }
}

#Preview {
    LoadIntoNFC(viewModel: .init())
}
