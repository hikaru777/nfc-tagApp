//
//  WriteIntoNFC.swift
//  wed-nfc
//
//  Created by 本田輝 on 2024/01/24.
//

import SwiftUI
import FirebaseAuth

struct WriteIntoNFC: View {
    
    var body: some View {
        
        VStack {
            //            TextField("", text: $viewModel.inputTextField)
            Button(action: {
                NFCManager.shared.write(text: "viewModel.inputTextField")
            },
                   label: {
                Text("書き込むﾖ")
            })
        }
        
        
    }
}
