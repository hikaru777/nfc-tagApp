//
//  CustomSimpleTabBar.swift
//  LocationMusicShareApp
//
//  Created by 本田輝 on 2023/11/17.
//

import SwiftUI

struct CustomSimpleTabBar: View {
    var animaiton: Namespace.ID

    var size: CGSize
    var bottomEdge: CGFloat

    @Binding var currentTab: Tab

    @State var startAnimation: Bool = false

    var body: some View {

        HStack(spacing: 0){

            ForEach(Tab.allCases, id: \.rawValue) { tab in

                TabButton(tab: tab, animation: animaiton, currentTab: $currentTab) { pressedTab in
                    withAnimation(.interactiveSpring(response: 0.3, dampingFraction: 0.4, blendDuration: 0.4)){
                        startAnimation = true
                    }
                    //                    withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.8, blendDuration: 0.8)){
                    //                        startAnimation = true
                    //                    }

                    DispatchQueue.main.asyncAfter(deadline: .now() ) {

                        withAnimation(.interactiveSpring(response: 0.3, dampingFraction: 0.5, blendDuration: 0.5)){
                            currentTab = pressedTab
                        }
                    }

                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {

                        withAnimation(.interactiveSpring(response: 0.3, dampingFraction: 0.5, blendDuration: 0.5)){
                            startAnimation = false
                        }
                    }

                }
            }
        }
        //        .background(
        //
        //            ZStack{
        //
        //                let animationOffset: CGFloat = (startAnimation ? (startAnimation ? 15 : 18) : (bottomEdge == 0 ? 26 : 27))
        //                let offset : CGSize = bottomEdge == 0 ? CGSize(width: animationOffset, height: 31) : CGSize(width: animationOffset, height: 36)
        //
        //                Rectangle()
        //                    .fill(.purple)
        //                    .frame(width: 30, height: 45)
        //                    .offset(y: 40)
        //
        //                Circle()
        //                    .fill(.gray)
        //                    .frame(width: 45, height: 45)
        //                    .scaleEffect(bottomEdge == 0 ? 0.8 : 1)
        //                    .offset(x: offset.width, y: offset.height)
        //                Circle()
        //                    .fill(.gray)
        //                    .frame(width: 45, height: 45)
        //                    .scaleEffect(bottomEdge == 0 ? 0.8 : 1)
        //                    .offset(x: -offset.width, y: offset.height)
        //            }
        //                .offset(x: getStartOffset())
        //                .offset(x: getOffset())
        //            ,alignment: .leading
        //        )
        .padding(.horizontal,15)
        .padding(.top, 7)
        .padding(.bottom,bottomEdge == 0 ? 23 : bottomEdge)
    }

    func getStartOffset()-> CGFloat {
        let reduced = (size.width - 30) / 3
        let center = (reduced - 45) / 2
        return center
    }

    func getOffset()-> CGFloat {
        let reduced = (size.width - 30) / 3
        let index = Tab.allCases.firstIndex { checkTab in

            return checkTab == currentTab
        } ?? 0

        return reduced * CGFloat(index)
    }
}

struct TabButton: View {
    var tab: Tab
    var animation: Namespace.ID
    @Binding var currentTab: Tab
    var onTap: (Tab)->()
    var body: some View {

        Button(action: {if currentTab != tab { onTap(tab) }}, label: {
            Image(systemName: currentTab != tab ? tab.symbolName : tab.symbolFillName )
                .foregroundColor(.white)
                .frame(width: 45, height: 45)
                .background(

                    ZStack{
                        if currentTab == tab {
                            Circle()
                                .fill(.blue.opacity(0.4))
                                .matchedGeometryEffect(id: "TAB", in: animation)
                        }
                    }
                )
                .frame(maxWidth: .infinity)
                .contentShape(Rectangle())
        })
        .disabled(currentTab == tab ? true : false)
    }
}
