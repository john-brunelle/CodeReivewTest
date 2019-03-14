//
//  MenuViewControllerCell.swift
//  Alliance-One
//
//  Created by John Brunelle on 3/7/19.
//  Copyright © 2019 Adept Mobile LLC. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class MenuViewControllerCell: UITableViewCell {
    
    @IBOutlet weak var menuName: UILabel!
    @IBOutlet weak var menuImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(iconIdentifier: String?) {
        if let iconIdentifier = iconIdentifier{
            print("menu iconIdentifier = \(iconIdentifier)")
            menuImage.image = UIImage(named: iconIdentifier)
        }
    }
    
    func set(name: String?) {
        if let name = name{
            print("menu name = \(name)")
             menuName.text = name
        }
    }

}
