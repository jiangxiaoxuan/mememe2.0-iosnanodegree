//
//  CollectionViewController.swift
//  Meme Me
//
//  Created by JiangXiaoxuan on 29/3/18.
//  Copyright © 2018 JiangXiaoxuan. All rights reserved.
//


import Foundation
import UIKit

// MARK: - VillainCollectionViewController: UICollectionViewController

class CollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    //This is an array of saved images.
    var memes: [Meme]{ return appDelegate.memes }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView?.reloadData();
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for:indexPath) as! MemeCollectionViewCell
        let meme = memes[(indexPath as NSIndexPath).row]
        
        // Set the image
        cell.MemeImageView?.image = meme.memedImage
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {

        let detailController = storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        detailController.meme = memes[(indexPath as NSIndexPath).row]
        navigationController!.pushViewController(detailController, animated: true)
    }
}

