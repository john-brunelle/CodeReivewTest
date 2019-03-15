//
//  CenterController.swift
//  Alliance-One
//
//  Created by John Brunelle on 3/5/19.
//  Copyright © 2019 Adept Mobile LLC. All rights reserved.
//

import UIKit
import RealmSwift

class CenterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var personaImage: UIImageView!
    
    var menuVC: MenuViewController?

    let delegate = UIApplication.shared.delegate as! AppDelegate
    private var data: [AppStoreReleasePersona] = []
    
    // token to keep observation of appStoreRelease alive
    var token: NotificationToken?
    
    deinit {
        token?.invalidate()
    }
    
    
    override func viewDidLoad() {
         //111111111111111111111111111111111111111111111111//1111111111111111111111111 100
        
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "team-logo")
        imageView.image = image
        navigationItem.titleView = imageView
        
        
        RealmPlatformDataProvider.shared().loginAndBindAppStoreRelease { [weak self]  appStoreRelease, error in
            
            if let error = error {
                fatalError(error.localizedDescription)
            }
            
            if let appStoreRelease = appStoreRelease {
                
                self?.delegate.realmStoreRelease = appStoreRelease
                
                let defaultPersona = appStoreRelease.appStoreReleasePersonas.first
                self?.delegate.currentStoreReleasePersona = defaultPersona
                self?.menuVC?.updateMenu()
          

                
                self?.token = appStoreRelease.appStoreReleasePersonas.observe { [weak self] _ in
                    
                    self?.data.removeAll()
                    
                    for appStoreReleasePersona in appStoreRelease.appStoreReleasePersonas {
                        print("+++++++++++= appStoreReleasePersona \(appStoreReleasePersona)")
                        self?.data.append(appStoreReleasePersona)
                    }
                    
                    self?.updatePersonaImage()
                    self?.tableView.reloadData()
                    self?.menuVC?.updateMenu()
                }
                
            }else{
                fatalError("APP STORE RELEASE IS NIL")
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personaCell")! as! CenterViewControllerCell
        
        let persona = data[indexPath.row]
        
        cell.set(name: persona.display_name)
        cell.set(imageURL: persona.logo_url)
    
        return cell
    }
    
    func updatePersonaImage(){
        
        if let imageURL =  delegate.currentStoreReleasePersona?.logo_url,
            let url = URL(string: imageURL){
            personaImage.af_setImage(withURL: url)
        }
        else{
            personaImage.image = UIImage(named: "persona-placeholder")
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let releasePersona = data[indexPath.row]
        delegate.currentStoreReleasePersona = releasePersona
        
        updatePersonaImage()
        
        menuVC?.updateMenu()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 44
    }
    
}
