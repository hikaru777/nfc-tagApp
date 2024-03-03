//
//  Double+convertedRadianToDegree.swift
//  nfc-tagApp
//
//  Created by 鈴木　葵葉 on 2024/03/02.
//

import Foundation

extension Double {

    func convertedRadianToDegree() -> Double {
        return self * 180 / Double.pi
    }
}

