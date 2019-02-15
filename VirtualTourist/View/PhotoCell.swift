//
//  PhotoCell.swift
//  VirtualTourist
//
//  Created by manar Aldossari on 07/06/1440 AH.
//  Copyright © 1440 MacBook Pro. All rights reserved.
//

import UIKit
import Kingfisher

class PhotoCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    let url = URL(string: "https://raw.githubusercontent.com/onevcat/Kingfisher/master/images/logo.png")
    
    func setimage(){
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: url)
        
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView = nil
        
    }
}
