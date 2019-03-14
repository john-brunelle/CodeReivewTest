//
//  MenuLabel.swift
//  Alliance-One
//
//  Created by John Brunelle on 3/7/19.
//  Copyright © 2019 Adept Mobile LLC. All rights reserved.
//

import Foundation
import RealmSwift

class MenuLabel: Object {
    @objc dynamic var id: Int = 0
    
    @objc dynamic var menu_tree_item_id: MenuTreeItem?
    @objc dynamic var language_id: Language?
    @objc dynamic var value: String?

    override static func primaryKey() -> String? {
        return "id"
    }
}
