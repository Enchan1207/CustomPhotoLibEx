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
    
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    var fetchResult: PHFetchResult = PHFetchResult<PHAsset>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requireAuthToPhotoLib()
        
        // collectionViewの初期化
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        let custonCell = UINib(nibName: "CollectionViewCell", bundle: nil)
        self.collectionView.register(custonCell, forCellWithReuseIdentifier: "thumbCell")

        // layout設定
        let itemsInRow = 4, padding: CGFloat = 2
        let itemWidth = self.view.frame.width / CGFloat(itemsInRow) - padding * 2

        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        layout.minimumInteritemSpacing = padding
        layout.minimumLineSpacing = padding
        layout.sectionInset = .init(top: 5, left: 5, bottom: 5, right: 5)
        collectionView.collectionViewLayout = layout
        
        // 並べ替えオプションを作って設定
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        fetchOptions.fetchLimit = 10
        fetchResult = PHAsset.fetchAssets(with: fetchOptions)
        
    }
    
    // フォトライブラリへのアクセスを要求する
    func requireAuthToPhotoLib(){
        let currentStatus = PHPhotoLibrary.authorizationStatus(for: .readWrite)
        
        // 許可されている?
        if [.authorized, .limited].contains(currentStatus){
            print("User has already granted access to the library.")
            return
        }
        
        // フォトライブラリへのアクセスを要求するプロンプトを出す
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { (status) in
            switch status {
            case .authorized: // 「すべての写真へのアクセスを許可」
                print("Authorized!")
                
            case .denied: // 「許可しない」
                print("Denied")
                
            case .limited: // 「写真を選択」
                print("Limited access")
                
            case .notDetermined: // ユーザがどうするか決めてない
                print("Not determined")
                
            case .restricted: // ユーザはフォトライブラリへのアクセスを許可できない
                print("Restricted")
                
            @unknown default:
                fatalError("!?")
            }
        }
        
    }
}
