//
//  Data.swift
//  nfc-tagApp
//
//  Created by 本田輝 on 2024/01/31.
//

import Foundation

struct ProfileData: Codable {
    var profileImage: String
    var userName: String?
}

struct ImageData: Codable {
    var imageUrl: String
    var gotAccounts: [String]?
}
