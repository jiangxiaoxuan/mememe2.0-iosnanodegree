//
//  MemeDetailViewController.swift
//  Meme Me
//
//  Created by JiangXiaoxuan on 4/4/18.
//  Copyright © 2018 JiangXiaoxuan. All rights reserved.
//

import Foundation
import UIKit

class MemeDetailViewController : UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    var meme : Meme!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = meme.memedImage
    }
}


