//
//  Language.swift
//  Alliance-One
//
//  Created by John Brunelle on 3/7/19.
//  Copyright © 2019 Adept Mobile LLC. All rights reserved.
//

import Foundation
import RealmSwift

class Language: Object {
    @objc dynamic var id: Int = 0
    
    @objc dynamic var name: String?
    @objc dynamic var system_name: String?
    @objc dynamic var country: String?
    @objc dynamic var region: String?

    override static func primaryKey() -> String? {
        return "id"
    }
}
