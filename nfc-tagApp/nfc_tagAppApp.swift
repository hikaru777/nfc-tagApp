//
//  nfc_tagAppApp.swift
//  nfc-tagApp
//
//  Created by 本田輝 on 2024/01/24.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
      
      Auth.auth().addStateDidChangeListener { auth, user in
          if user == nil {
              Auth.auth().signInAnonymously() { (authResult, error) in
                  if error != nil {
                      print("Auth Error :\(error!.localizedDescription)")
                  }
                  Task {
                      do {
                          let profileData = ProfileData(profileImage: "", userName: "")
                          try await FirebaseClient.settingProfile(data: profileData, uid: Auth.auth().currentUser!.uid)
                          try await FirebaseClient.setImage(uid: Auth.auth().currentUser!.uid, imageUrl: ImageData(imageUrl: "", gotAccounts: []))
                          
                          UserDefaults.standard.set(true, forKey: "logIned")
                          
                      } catch {
                          print("アカウント作成時のエラー",error.localizedDescription)
                      }
                  }
                  
                  // 認証情報の取得
                  guard let user = authResult?.user else { return }
                  return
              }
          } else {
              print("ログインされてるにょ")
              UserDefaults.standard.set(true, forKey: "logIned")
          }
      }

    return true
  }
}

@main
struct nfc_tagAppApp: App {
  // register app delegate for Firebase setup
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate


  var body: some Scene {
    WindowGroup {
      NavigationView {
          MainView()
      }
    }
  }
}
