//
//  CustomSimpleTab.swift
//  LocationMusicShareApp
//
//  Created by 本田輝 on 2023/11/17.
//

import SwiftUI

struct CustomSimpleTab: View {
    @State var currentTab: Tab = .playing
    
    init(size: CGSize, bottomEdge: CGFloat, viewModel: TabViewModel) {
        self.size = size
        self.bottomEdge = bottomEdge
        self.viewModel = viewModel
        UITabBar.appearance().isHidden = true
    }
    @ObservedObject var viewModel: TabViewModel
    @Namespace var animation
    var size: CGSize
    var bottomEdge: CGFloat
    let longer = max(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
    @State var dontTouch = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            TabView(selection: $currentTab) {
                
//                LoadIntoNFC(viewModel: .init())
//                    .tag(Tab.setting)
//                
//                WriteIntoNFC(viewModel: .init())
//                    .tag(Tab.playing)
//                
//                WriteIntoNFC(viewModel: .init())
//                    .tag(Tab.list)
                
                
            }
            .ignoresSafeArea(.keyboard)
            .preferredColorScheme(.light)
            
            CustomSimpleTabBar(animaiton: animation,size: size ,bottomEdge: bottomEdge, currentTab: $currentTab)
                .background(returnTabBackView())
        }
    }
    
    func returnTabBackView() -> AnyView {
        // ここでビューを作成して返す
        if currentTab == .setting {
            return AnyView(SubView1())
        } else {
            return AnyView(SubView2())
            
        }
    }
    
    struct SubView1: View {
        var body: some View {
            RoundedRectangle(cornerSize: .zero).foregroundStyle(.ultraThinMaterial)
        }
    }
    
    struct SubView2: View {
        var body: some View {
            RoundedRectangle(cornerSize: .zero).foregroundStyle(.ultraThinMaterial.opacity(0.5))
        }
    }
    
    
}
