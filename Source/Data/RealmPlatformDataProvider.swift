//
//  DataProvider.swift
//  Alliance-One
//
//  Created by Craig Heneveld on 2/22/19.
//  Copyright © 2019 Adept Mobile LLC. All rights reserved.
//

import Foundation
import RealmSwift

// PLEASE READ https://docs.realm.io/sync/
// PLEASE READ https://realm.io/docs/swift/latest/

// READ -----
// Realm is a read only Datastore
// The Models must match the schema EXACTLY or app will crash or behave oddly
// When deving on the schema YOU MUST MAKE SMALL INCREMENTAL CHANGES THEN RUN to test

class RealmPlatformDataProvider {
    
    // MARK: - Properties
    
    private static var sharedDataProvider: RealmPlatformDataProvider = {
        // TODO: These vars should be overridable by bitrise push, lets define what that means, ENV vars or GLOBALs or something
        
        let realmCloudAddressRaw = Bundle.main.object(forInfoDictionaryKey: "REALM_HOST") as! String
        let realmCloudAddress = realmCloudAddressRaw.replacingOccurrences(of: "realms://", with: "")
        let realmPath = Bundle.main.object(forInfoDictionaryKey: "REALM_PATH") as! String
        let appStoreReleaseId = Int(Bundle.main.object(forInfoDictionaryKey: "REALM_APP_RELEASE_ID") as! String)!
        
        print(">>>>> Realm RealmPath = \(realmPath)")
        print(">>>>> Realm Host = \(realmCloudAddress)")
        print(">>>>> Realma Release Id = \(appStoreReleaseId)")
        
        let dataProviderManager = RealmPlatformDataProvider(realmCloudAddress: realmCloudAddress, realmPath: realmPath, appStoreReleaseId: appStoreReleaseId)
        
        return dataProviderManager
    }()
    
    // MARK: -
    
    fileprivate let authRealmURL: URL
    fileprivate let realmURL: URL
    
    //TODO: appStoreReleaseId to be set by bitrise build trigger
    fileprivate let appStoreReleaseId: Int
    
    // Initialization
    private init(realmCloudAddress: String, realmPath: String, appStoreReleaseId: Int) {
        self.authRealmURL = URL(string: "https://" + realmCloudAddress)!
        self.realmURL = URL(string: "realms://" + realmCloudAddress + realmPath)!
        
        self.appStoreReleaseId = appStoreReleaseId
        
        SyncManager.shared.logLevel = .debug
        
        SyncManager.shared.errorHandler = { error, session in
            //TODO: More reboust and meaningful error handling
            // Logging out and fatal is for developing and making sure we don't miss any oddities
            
            // Logging a user out of the Realm will make them unable to access synchronized realms.  If you want to allow access to the local copy of a synced Realm while offline, do not make code your app to Realm logout an automatic process  when the application is force quitted.
            
            // To log a user out of their account, call SyncUser.logOut(). Any pending local changes will continue to upload until the Realm Object Server is fully synchronized. The next time the client app is launched, all synced Realms will be deleted from the user's device.
            SyncUser.current?.logOut()
            
            print(error)
            
            
            fatalError(error.localizedDescription)
        }
    }
    
    // MARK: - Accessors
    
    class func shared() -> RealmPlatformDataProvider {
        return sharedDataProvider
    }

    public func loginAndBindAppStoreRelease(completion: @escaping ((AppStoreRelease?, Error?)->())) {
        if let user = SyncUser.current {
            bindAppStoreRelease(user: user, completion: completion)
        }else{
            
            //usernamePassword cres are here is just for testing, we will need to use anonymous() in store app but currently getting
            
            // "Permission denied (BIND, REFRESH)" UserInfo={error_action_token=<RLMSyncErrorActionToken: 0x6000007b9380>, NSLocalizedDescription=Permission denied (BIND, REFRESH), statusCode=206} #0
            
            // when this error happens we lose connection to realm and cant get the auto update
            
            //let creds = SyncCredentials.anonymous()
            
            // If permissioning/access becomes a problem with the anonymous user, just use admin creds to keep working and hit up hench
            let creds = SyncCredentials.usernamePassword(username: "sync-admin", password: "ztfVzyRU2zakwP3")
            SyncUser.logIn(with: creds, server: RealmPlatformDataProvider.shared().authRealmURL) { [weak self] user, error in
                
                if let error = error {
                    print("ERROR LOGIN")
                    dump(error)
                }
                
                guard let user = user else {
                    fatalError("Could not bind to AppStoreRelease: user = nil")
                }
                
                self?.bindAppStoreRelease(user: user, completion: completion)
            }
        }
    }
    
    fileprivate func bindAppStoreRelease(user: SyncUser, completion: @escaping ((AppStoreRelease?, Error?)->())) {
        let syncConfig = user.configuration(realmURL: RealmPlatformDataProvider.shared().realmURL, fullSynchronization: true)
        
        Realm.Configuration.defaultConfiguration = syncConfig
        
        Realm.asyncOpen { [weak self] realm, error in
            
            if let error = error {
                completion(nil, error)
            }
            
            if let appStoreRelease = realm?.object(ofType: AppStoreRelease.self, forPrimaryKey: self?.appStoreReleaseId) {
                completion(appStoreRelease, nil)
            }else{
                completion(nil, RealmPlatformDataProviderError.runtimeError("Couldn't find AppStoreRelease with id = \(self?.appStoreReleaseId ?? -1)"))
            }
        }
    }
}

enum RealmPlatformDataProviderError: Error {
    case runtimeError(String)
}
