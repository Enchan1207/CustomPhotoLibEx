//
//  CollectionViewCell.swift
//  CustomPhotoLIbEx
//
//  Created by EnchantCode on 2021/01/19.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var image: UIImage?{
        get{
            return self.imageView.image
        }
        
        set(img){
            self.imageView.image = img
            // self.setNeedsDisplay() // パフォーマンス低下しそう
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
