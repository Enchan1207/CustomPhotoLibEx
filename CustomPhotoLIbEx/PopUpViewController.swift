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
    @IBOutlet weak var rectLabel: UILabel!
    
    var asset: PHAsset?
    
    override func viewWillAppear(_ animated: Bool) {
        // imageView設定
        guard let asset = self.asset else {return}
        let size = self.view.frame.size
        DispatchQueue.global().async {
            PHCachingImageManager().requestImage(for: asset, targetSize: size, contentMode: .aspectFill, options: nil) { (image, nil) in
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
        
        // label設定
        let width = self.asset?.pixelWidth ?? 0
        let height = self.asset?.pixelHeight ?? 0
        rectLabel.text = "size: \(width) x \(height)"
    }
    
    override func viewDidLoad() {
        // Write Additional setting
    }
}
