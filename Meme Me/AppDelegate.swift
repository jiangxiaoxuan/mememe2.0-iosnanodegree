//
//  AppDelegate.swift
//  Meme Me
//
//  Created by JiangXiaoxuan on 18/2/18.
//  Copyright © 2018 JiangXiaoxuan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var memes = [Meme]()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
}

