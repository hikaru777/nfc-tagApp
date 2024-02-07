//
//  SendToDB.swift
//  LocationMusicShareApp
//
//  Created by 本田輝 on 2023/08/24.
//

import Foundation
import FirebaseStorage
import UIKit
import FirebaseAuth

protocol SendProfileOKDelegate {
    
    func sendProfileOKDelegate(url:String)
    
}

class SendToDBModel {
    var sendProfileOKelegate:SendProfileOKDelegate?
    
    func uploadProfileImage(image: UIImage) async -> URL? {
        guard let profileImageData = image.pngData() else { return nil }
        
        let imageRef = Storage.storage().reference().child("profileImage").child("\(UUID().uuidString + String(Date().timeIntervalSince1970)).jpg")
        
        let _ = try? await imageRef.putDataAsync(profileImageData)
        
        let url = try? await imageRef.downloadURL()
        UserDefaults.standard.set(url, forKey: "userImage")
        
        return url
    }
    
    func uploadProfileViewImage(image: UIImage) async -> URL? {
        guard let profileImageData = image.pngData() else { return nil }
        
        let imageRef = Storage.storage().reference().child("profileImage").child("\(UUID().uuidString + String(Date().timeIntervalSince1970)).jpg")
        
        let _ = try? await imageRef.putDataAsync(profileImageData)
        
        let url = try? await imageRef.downloadURL()
        UserDefaults.standard.set(url, forKey: "userViewImage")
        
        return url
    }
    
    func uploadProfileImageOverSize(image: UIImage) async -> URL? {
        guard let profileImageData = image.jpegData(compressionQuality: 0.1) else { return nil }
        
        let imageRef = Storage.storage().reference().child("profileImage").child("\(UUID().uuidString + String(Date().timeIntervalSince1970)).jpg")
        
        let _ = try? await imageRef.putDataAsync(profileImageData)
        
        let url = try? await imageRef.downloadURL()
        UserDefaults.standard.set(url, forKey: "userImage")
        
        return url
    }
}
