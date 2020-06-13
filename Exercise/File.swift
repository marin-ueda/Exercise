//
//  File.swift
//  Exercise
//
//  Created by 植田真梨 on 2020/06/13.
//  Copyright © 2020 Ueda Maririn. All rights reserved.
//

import Foundation
import RealmSwift

class File: Object {
    @objc dynamic var goukei: Int = 0
    @objc dynamic var hiniti = ""

//    dynamic var value: Date? = nil
    //0610 日付のために追加
    override static func primaryKey() -> String? {
        return "hiniti"
     }
}
