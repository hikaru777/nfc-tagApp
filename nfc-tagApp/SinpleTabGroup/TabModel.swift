//
//  TabModel.swift
//  LocationMusicShareApp
//
//  Created by 本田輝 on 2023/08/23.
//

import SwiftUI
import MediaPlayer

enum Tab: Int, CaseIterable {
    case setting = 0
    case playing = 1
    case list = 2
    
    var index: CGFloat {
        return CGFloat(Tab.allCases.firstIndex(of: self) ?? 0)
    }
    
    var symbolName: String {
        switch self {
        case .setting:
//            return "mappin.and.ellipse.circle"
            return "person.circle"
        case .playing:
//            if MPMusicPlayerController.applicationMusicPlayer.playbackState == .paused {
                return "play"
//            } else {
//                return "pause"
//            }
        case .list:
            return "music.note"
        }
        
        
    }
    
    var symbolFillName: String {
        switch self {
        case .setting:
//            return "mappin.and.ellipse.circle.fill"
            return "person.circle.fill"
        case .playing:
//            if MPMusicPlayerController.applicationMusicPlayer.playbackState == .paused {
                return "play.fill"
//            } else {
//                return "pause.fill"
//            }
        case .list:
            return "music.note.list"
        }
    }
    
    var tabName: String{
        switch self {
        case .setting:
            return "setting"
        case .playing:
            return "playing"
        case .list:
            return "list"
        }
    }
    
    static var count: CGFloat {
        return CGFloat(Tab.allCases.count)
    }
    
    
}
