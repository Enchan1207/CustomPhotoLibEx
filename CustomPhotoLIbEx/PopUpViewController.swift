//
//  PopUpViewController.swift
//  CustomPhotoLIbEx
//
//  Created by EnchantCode on 2021/01/19.
//

import Foundation
import UIKit
import Photos

class PopUpViewController: UIViewController{
    
    @IBOutlet weak var imageView: UIImageView!
    
    var asset: PHAsset?
    
    override func viewWillAppear(_ animated: Bool) {
        guard let asset = self.asset else {return}
        let size = self.view.frame.size
        
        DispatchQueue.global().async {
            PHCachingImageManager().requestImage(for: asset, targetSize: size, contentMode: .aspectFill, options: nil) { (image, nil) in
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
    }
    
    override func viewDidLoad() {
        // Write Additional setting
    }
}
