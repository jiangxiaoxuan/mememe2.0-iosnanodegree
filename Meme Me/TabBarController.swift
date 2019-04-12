//
//  TabBarController.swift
//  Meme Me
//
//  Created by JiangXiaoxuan on 2/4/18.
//  Copyright © 2018 JiangXiaoxuan. All rights reserved.
//

import Foundation
import UIKit

class TabBarController : UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New Meme", style: .plain, target: self, action: #selector(newImage))
    }
    
    @objc func newImage(){
        let storyboard = UIStoryboard (name: "Main", bundle: nil)
        let newImageVC = storyboard.instantiateViewController(withIdentifier: "NewImage")as! NewImageViewController
        
        let navigationController = UINavigationController()
        navigationController.viewControllers = [newImageVC]
        self.navigationController?.present(navigationController, animated: true, completion: nil)
    }
}
