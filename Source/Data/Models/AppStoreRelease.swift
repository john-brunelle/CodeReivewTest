//
//  AppStoreRelease.swift
//  Alliance-One
//
//  Created by Craig Heneveld on 2/25/19.
//  Copyright © 2019 Adept Mobile LLC. All rights reserved.
//

import Foundation
import RealmSwift

class AppStoreRelease: Object {
    @objc dynamic var id: Int = 0
    
    @objc dynamic var semantic_version: String?
    @objc dynamic var status: String?
    @objc dynamic var internal_url_scheme: String?
    
    let appStoreReleasePersonas = LinkingObjects(fromType: AppStoreReleasePersona.self, property: "app_store_release_id")
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
