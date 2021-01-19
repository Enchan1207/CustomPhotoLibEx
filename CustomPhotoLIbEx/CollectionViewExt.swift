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
        
        // PHAsset持ってきてセルに渡す
        let index = indexPath.row
        let asset = self.fetchResult.object(at: index)
        cell.asset = asset
        return cell
    }
}


