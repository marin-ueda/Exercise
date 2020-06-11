//
//  Kiroku.swift
//  Exercise
//
//  Created by 植田真梨 on 2020/06/08.
//  Copyright © 2020 Ueda Maririn. All rights reserved.
//

import Foundation
import RealmSwift

class Kiroku: Object {
    @objc dynamic var seconds: Double = 0.0
//    dynamic var value = Date()
    @objc dynamic var hiniti = ""

//    dynamic var value: Date? = nil
    //0610 日付のために追加
    override static func primaryKey() -> String? {
        return "hiniti"
     }
}
