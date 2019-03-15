//
//  MenuViewController.swift
//  DrawerMenuExample
//
//  Created by Florian Marcu on 1/17/18.
//  Copyright © 2018 iOS App Templates. All rights reserved.
//

import UIKit
import RealmSwift


class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var personaImage: UIImageView!
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    private var data: [MenuTreeItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    func updateMenu(){
        
        data.removeAll()
        if let storeReleasePersona = delegate.currentStoreReleasePersona {
            
            //print("+++++++++++= MENU  = \(String(describing: storeReleasePersona.display_name))")
            
            if let imageURL =  delegate.currentStoreReleasePersona?.logo_url,
                let url = URL(string: imageURL){
                personaImage.af_setImage(withURL: url)
                
            }
            else{
                personaImage.image = UIImage(named: "persona-placeholder")
            }
            
            if let menu = storeReleasePersona.menu_id {
                if let menuTreeItems = menu.menuTreeItems() {
                    for menuTreeItem in menuTreeItems {
                        // print("+++++++++++= menuTreeItem  = \(menuTreeItem)")
                        
                        print("ccccc+++++++++++= menuTreeItem.labels  = \(menuTreeItem.menuLabel()!)")
                        
                        self.data.append(menuTreeItem)
                        
                        self.tableView.reloadData()
                    }
                }
                
                self.tableView.reloadData()
            }
            
        }else{
            fatalError("Menu Persona is nil")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell")! as! MenuViewControllerCell
        
        let menuItem = data[indexPath.row]
        
        cell.set(iconIdentifier: menuItem.icon_identifier)
        cell.set(name:menuItem.menuLabel()?.first?.value)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // let releasePersona = data[indexPath.row]
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}

