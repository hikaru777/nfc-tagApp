//
//  CheckPermission.swift
//  LocationMusicShareApp
//
//  Created by 本田輝 on 2023/08/24.
//

import Foundation
import Photos

class CheckPermission{
    
    func showCheckPerission() {
        PHPhotoLibrary.requestAuthorization { (status) in
            
            switch(status) {
                
            case .authorized:
                print("許可されてますよ")
                
            case .denied:
                print("拒否")
                
            case .notDetermined:
                print("notDetermined")
                
            case .restricted:
                print("restricted")
                
            case .limited:
                print("limited")
            @unknown default: break
            }
        }
    }
    
}

