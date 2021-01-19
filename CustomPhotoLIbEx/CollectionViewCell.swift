//
//  CollectionViewCell.swift
//  CustomPhotoLIbEx
//
//  Created by EnchantCode on 2021/01/19.
//

import UIKit
import Photos

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    private var _asset: PHAsset?
    public var asset: PHAsset?{
        get{
            return self._asset
        }
        
        set(asset){
            self._asset = asset
            updateImageViewFromAsset()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func updateImageViewFromAsset(){
        guard let asset = self.asset else {return}
        let imageViewFrameSize = self.imageView.frame.size
        
        PHCachingImageManager().requestImage(
            for: asset,
            targetSize: imageViewFrameSize,
            contentMode: .aspectFill,
            options: nil
        ) { (image, nil) in
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }
}
