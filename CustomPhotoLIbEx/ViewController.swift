//
//  ViewController.swift
//  CustomPhotoLIbEx
//
//  Created by EnchantCode on 2021/01/19.
//

import UIKit
import Photos

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var canAccessPhotoLib: Bool?
    var fetchResult: PHFetchResult = PHFetchResult<PHAsset>()
    let fetchOptions: PHFetchOptions = PHFetchOptions()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // フォトライブラリにアクセスできるか確認
        requestAuthToPhotoLib()
        
        // collectionView初期化
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        let custonCell = UINib(nibName: "CollectionViewCell", bundle: nil)
        self.collectionView.register(custonCell, forCellWithReuseIdentifier: "thumbCell")

        // layout設定
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()

        layout.itemSize = CGSize(width: 100, height: 100)
//        layout.minimumInteritemSpacing = 2
//        layout.minimumLineSpacing = 2
//        layout.sectionInset = .init(top: 5, left: 5, bottom: 5, right: 5)
        collectionView.collectionViewLayout = layout
        
        // fetchOptionを設定
        self.fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        self.fetchOptions.fetchLimit = 100
        
    }
    
    // フォトライブラリから画像をフェッチする
    func updateFetchResult(){
        self.fetchResult = PHAsset.fetchAssets(with: self.fetchOptions)
    }
    
    // フォトライブラリにアクセスできるか確認
    func requestAuthToPhotoLib(){
        // すでに許可されている?
        let currentStatus = PHPhotoLibrary.authorizationStatus(for: .readWrite)
        if [.authorized, .limited].contains(currentStatus){
            self.canAccessPhotoLib = true
            self.updateFetchResult()
            return
        }
        
        // アクセス要求プロンプトを出す
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { (status) in
            if [.authorized, .limited].contains(status){
                self.canAccessPhotoLib = true
                self.updateFetchResult()
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }else{
                self.canAccessPhotoLib = false
            }
        }
    }
}
