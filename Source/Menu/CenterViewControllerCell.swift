//
//  CenterViewControllerCell.swift
//  Alliance-One
//
//  Created by John Brunelle on 3/6/19.
//  Copyright © 2019 Adept Mobile LLC. All rights reserved.
//

import UIKit

class CenterViewControllerCell: UITableViewCell{
    
    @IBOutlet weak var personaName: UILabel!
    @IBOutlet weak var personaImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func set(name: String?) {
        if let name = name{
            print("Perseona name = \(name)")
            personaName.text = name
        }
    }
    
    func set(imageURL: String?) {
        
        print("@@@@@@ Perseona imageURL = \(imageURL)")
        
        if let imageURL = imageURL{
            
            
            let placeholderImage = UIImage(named: "persona-placeholder")!
            
            if let url = URL(string: imageURL) {
                personaImage.af_setImage(withURL: url, placeholderImage: placeholderImage, imageTransition: .crossDissolve(0.5))
            }
            
        }
        else{
            personaImage.image = UIImage(named: "persona-placeholder")
        }
    }
    
}
