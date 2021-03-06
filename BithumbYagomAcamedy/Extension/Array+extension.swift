//
//  Array+extension.swift
//  BithumbYagomAcamedy
//
//  Created by 황제하 on 2022/03/05.
//

import Foundation

extension Array {
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
