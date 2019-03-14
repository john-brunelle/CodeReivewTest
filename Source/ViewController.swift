//
//  ViewController.swift
//  Alliance-One
//
//  Created by John Brunelle on 1/16/19.
//  Copyright © 2019 AdeptMobile LLC. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var applabel: UILabel!
    
    @IBOutlet weak var logo: UIImageView!
    
    @IBOutlet weak var news: UIImageView!
    @IBOutlet weak var stadium: UIImageView!
    @IBOutlet weak var shop: UIImageView!
    @IBOutlet weak var ticket: UIImageView!
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mainVC = UIStoryboard(name: "CenterViewController", bundle: nil).instantiateInitialViewController()! as! CenterViewController
        
        let menuVC = UIStoryboard(name: "MenuViewController", bundle: nil).instantiateInitialViewController()! as! MenuViewController
        
        mainVC.menuVC = menuVC
        
        
        let rootController = RootViewController(mainViewController: mainVC, topNavigationLeftImage: UIImage(named: "hamburger-menu-icon"))
        
        let drawerVC = DrawerController(rootViewController: rootController, menuController: menuVC)
        
        self.addChild(drawerVC)
        view.addSubview(drawerVC.view)
        drawerVC.didMove(toParent: self)

        // I added this comment for codereview testing. I added this comment
        //for codereview testing.
        
        //11111111111111111111111111111111111111mmsdmasmdfmasdfmasmdfmasdfmasmdfmas
        
        //111111111111111111111111111111111111111111111111//1111111111111111111111111111111111111111111 100 1
    }
    
    func createImages(){
        
        logo.image = UIImage(named: "team-logo")
        
        news.image = UIImage(named: "menu-icon-news")
        stadium.image = UIImage(named: "menu-icon-stadium")
        shop.image = UIImage(named: "menu-  -shop")
        ticket.image = UIImage(named: "menu-icon-ticket-exchange")
        
    }
}
