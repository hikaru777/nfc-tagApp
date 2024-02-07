//
//  FirebaseClient.swift
//  nfc-tagApp
//
//  Created by 本田輝 on 2024/01/31.
//

import Foundation
import Combine
import FirebaseAuth
import FirebaseFirestore
import FirebaseDatabase
import FirebaseFirestoreSwift
import SwiftUI

enum FirebaseClientFirestoreError: Error {
    case roomDataNotFound
}

class FirebaseClient {
    
    static let db = Firestore.firestore()
    
    static func settingProfile(data: ProfileData, uid: String) async throws {
        
        guard let encoded = try? Firestore.Encoder().encode(data) else { return }
        try await db.collection("data").document(uid).collection("userData").document("profileData").setData(encoded)
        
    }
    
    static func getProfileData(uid: String) async throws -> ProfileData {
        let snapshot = try await db.collection("data").document(uid).collection("userData").document("profileData").getDocument()
        let information = try snapshot.data(as: ProfileData.self)
        return information
    }
    
    static func setImage(uid: String, imageUrl: ImageData) async throws {
        guard let encoded = try? Firestore.Encoder().encode(imageUrl) else { return }
        try await db.collection("data").document(uid).setData(encoded)
    }
    
    static func getProfileViewData(uid: String) async throws -> ImageData {
        let snapshot = try await db.collection("data").document(uid).getDocument()
        let information = try snapshot.data(as: ImageData.self)
        return information
    }
}
