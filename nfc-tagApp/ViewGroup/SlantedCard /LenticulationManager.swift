//
//  LenticulationManager.swift
//  nfc-tagApp
//
//  Created by 鈴木　葵葉 on 2024/03/02.
//

import CoreMotion
import CoreGraphics
import SwiftUI

class LenticulationManager: ObservableObject {

    @Published var middleImageOpacity: CGFloat = 1
    @Published var frontImageOpacitry: CGFloat = 0
    @Published var degree: Float = 0
    
    private let motionManager = CMMotionManager()

    ///  基準にする角度
    private let baseDegrees: CGFloat = 60

    init() {
        if motionManager.isDeviceMotionAvailable {
            startUpdatingLenticulation()
        }
    }

    private func startUpdatingLenticulation() {
        // 1秒間に60回アップデートする
        motionManager.deviceMotionUpdateInterval = 1.0 / 60.0
        motionManager.startDeviceMotionUpdates(to: OperationQueue.current!) { (deviceMotion, error) in
            guard let deviceMotion = deviceMotion,
                  error == nil
            else { return }

            // ラジアンを角度に変換
            let degree = deviceMotion.attitude.roll.convertedRadianToDegree()
            self.degree = Float(degree)
            // 角度から姿勢状態に変換
            let attitudeState = DeviceAttitudeState(degree)
            // 姿勢の状態に応じてImageOpacityの値を更新
            self.updateImageOpacity(with: attitudeState)
//            self.voronoi = self.makeVoronoi()
            print(deviceMotion.attitude.roll.convertedRadianToDegree())
        }
    }
    
    /// デバイスの姿勢状態に応じてImageOpacityの値を更新
    private func updateImageOpacity(with attributeState: DeviceAttitudeState) {

        switch attributeState {
        case .flat:
            update(middleImageOpacity: 0, andFrontImageOpacity: 0)
        case .forward(let degree):
            let frontOpacity = degree >= baseDegrees ?  1 : degree / baseDegrees
            update(middleImageOpacity: 0, andFrontImageOpacity: frontOpacity)
        case .backward(let degree):
            let middleOpacity = degree >= baseDegrees ?  1 : degree / baseDegrees
            update(middleImageOpacity: middleOpacity, andFrontImageOpacity: 0)
        }
    }

    private func update(middleImageOpacity: CGFloat,
                        andFrontImageOpacity frontImageOpacty: CGFloat) {
        self.middleImageOpacity = middleImageOpacity
        self.frontImageOpacitry = frontImageOpacty
        print("😞",frontImageOpacty)
        print("🙄",middleImageOpacity)
    }
}

extension LenticulationManager {

    enum DeviceAttitudeState {
        case flat
        case forward(degree: Double)
        case backward(degree: Double)

        init(_ degree: Double) {

            switch degree {
            case 1...180:
                self = .forward(degree: degree)
            case -180 ... -1:
                let positiveDegree = degree * -1
                self = .backward(degree: positiveDegree)
            default:
                self = .flat
            }
        }
    }
}
