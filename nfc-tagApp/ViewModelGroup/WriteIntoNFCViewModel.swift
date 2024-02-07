//
//  WriteIntoNFCViewModel.swift
//  wed-nfc
//
//  Created by 本田輝 on 2024/01/24.
//

import Foundation
import SwiftUI

class WriteIntoNFCViewModel: NSObject, ObservableObject {
    
    @Published var showPickerView: Bool = false
    @Published var decidedProfileImageUrl: String = ""
    @Published var sendToDBModel = SendToDBModel()
    @Published var uid: String = ""
    
    @Published var capturedImage: UIImage?
    @Published var imageUrl = URL(string: "")
    @Published var showXButton = false
    @Published var opacity = 100
    
}
