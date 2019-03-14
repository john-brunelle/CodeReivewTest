//
//  MenuTreeItem.swift
//  Alliance-One
//
//  Created by Craig Heneveld on 2/25/19.
//  Copyright © 2019 Adept Mobile LLC. All rights reserved.
//

import Foundation
import RealmSwift

class MenuTreeItem: Object {
    @objc dynamic var id: Int = 0
    
    @objc dynamic var name: String?
    @objc dynamic var menu_parent_type: String?  //Menu or MenuTreeItem
    @objc dynamic var icon_identifier: String?
    
    let menu_parent_id = RealmOptional<Int>()
    let position = RealmOptional<Int>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func menuLabel(for language: String = "en") -> Results<MenuLabel>? {
        return realm?.objects(MenuLabel.self).filter("menu_tree_item_id.id = \(self.id) AND language_id.system_name == '\(language)'")
    }
}
