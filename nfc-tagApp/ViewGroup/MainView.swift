//
//  MainView.swift
//  wed-nfc
//
//  Created by 本田輝 on 2024/01/24.
//

import SwiftUI

struct MainView: View {
    @Environment(\.scenePhase) private var scenePhase
    //    @StateObject var viewModel: MusicPlayerFeatureModel
    @State var activeTab: Tab = .playing
    var firstAlert: Bool!
    let longer = max(UIScreen.main.bounds.width, UIScreen.main.bounds.height)

    var body: some View {

        GeometryReader{ proxy in

            let size = proxy.size
            let bottom = proxy.safeAreaInsets.bottom

            CustomSimpleTab(size: size, bottomEdge: bottom, viewModel: .init())
                .ignoresSafeArea(.all, edges: .bottom)


        } .ignoresSafeArea(.keyboard)
            .preferredColorScheme(.light)

    }
}
