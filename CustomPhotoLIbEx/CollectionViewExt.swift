//
//  CollectionViewExt.swift
//  CustomPhotoLIbEx
//
//  Created by EnchantCode on 2021/01/19.
//

import Foundation
import UIKit
import Photos

extension ViewController: UICollectionViewDelegate {
    
    // セル選択時の処理
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // PHAsset持ってきて
        let index = indexPath.row
        let asset = self.fetchResult.object(at: index)
        
        // Segue経由でVCに投げる
        self.performSegue(withIdentifier: "PopupSegue", sender: asset)
        
    }
    
    // Segueによる移動時に呼び出される
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // identifier分岐
        if(segue.identifier == "PopupSegue"){
            // 飛び先とsenderを取得
            guard let destination = segue.destination as? PopUpViewController else {return}
            guard let asset = sender as? PHAsset else {return}
            
            destination.asset = asset
            destination.navigationItem.title = "え、なにこれ"
        }
    }
    
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.fetchResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // セル作って
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "thumbCell", for: indexPath) as! CollectionViewCell
        
        // PHAsset持ってきて
        let index = indexPath.row
        let asset = self.fetchResult.object(at: index)
        
        // 画像を取得し割り当て
        // HACK: クソ実装 これだと画像多くなったときに凍る(UI更新がrequestimageで遅れるのは多分まずい)
        // セル表示の過程でPHAsset->UIImageをやるのはやはり頭が悪いか
        let options = PHImageRequestOptions()
        options.deliveryMode = .highQualityFormat
        
        let cellSize = cell.frame.size
        DispatchQueue.global().async {
            PHCachingImageManager().requestImage(for: asset, targetSize: cellSize, contentMode: .aspectFill, options: options) { (image, nil) in
                DispatchQueue.main.async {
                    cell.image = image
                }
            }
        }
        
        return cell
    }
}


