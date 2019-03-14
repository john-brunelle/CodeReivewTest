//
//  AppStoreReleasePersona.swift
//  Alliance-One
//
//  Created by Craig Heneveld on 2/25/19.
//  Copyright © 2019 Adept Mobile LLC. All rights reserved.
//

import Foundation
import RealmSwift

class AppStoreReleasePersona: Object {
    @objc dynamic var id: Int = 0
    
    @objc dynamic var app_store_release_id: AppStoreRelease?
    @objc dynamic var persona_id: Persona?
    @objc dynamic var menu_id: Menu?
    @objc dynamic var semantic_version: String?
    @objc dynamic var display_name: String?
    @objc dynamic var data_updated_at: Date?
    @objc dynamic var logo_url: String?
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
