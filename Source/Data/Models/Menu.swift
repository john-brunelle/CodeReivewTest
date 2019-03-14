//
//  Menu.swift
//  Alliance-One
//
//  Created by Craig Heneveld on 2/25/19.
//  Copyright © 2019 Adept Mobile LLC. All rights reserved.
//

import Foundation
import RealmSwift

class Menu: Object {
    @objc dynamic var id: Int = 0
    
    @objc dynamic var semantic_version: String?
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    // MenuTreeItems are polymorphic
    func menuTreeItems() -> Results<MenuTreeItem>? {
        return realm?.objects(MenuTreeItem.self).filter("menu_parent_type = 'Menu' AND menu_parent_id == %d", self.id).sorted(byKeyPath: "position")
    }
    
    func menuTreeItems2() -> Results<MenuTreeItem>? {
        
        return realm?.objects(MenuTreeItem.self).filter("menu_parent_type = 'Menu' AND menu_parent_id == %d", self.id,self.id,1).sorted(byKeyPath: "position")
    }
    
    
    func menuTreeItems3() -> Results<MenuTreeItem>? {
        return realm?.objects(MenuTreeItem.self).filter("menu_parent_type = 'Menu' AND menu_parent_id == %d AND menuLabels.menu_tree_item_id = %d AND menuLabels.language_id == %d", self.id,self.id,1).sorted(byKeyPath: "position")
    }
    
    
}
