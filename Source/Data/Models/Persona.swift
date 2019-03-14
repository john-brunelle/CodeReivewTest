//
//  Persona.swift
//  Alliance-One
//
//  Created by Craig Heneveld on 2/25/19.
//  Copyright © 2019 Adept Mobile LLC. All rights reserved.
//

import Foundation
import RealmSwift

class Persona: Object {
    @objc dynamic var id: Int = 0
    
    let appStoreReleasePersona = LinkingObjects(fromType: AppStoreReleasePersona.self, property: "persona_id")
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
