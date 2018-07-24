//
//  AppDelegate.swift
//  Todoey
//
//  Created by José María Aguíñiga Díaz on 13/07/18.
//  Copyright © 2018 José María Aguíñiga Díaz. All rights reserved.
//

import UIKit

import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        print(Realm.Configuration.defaultConfiguration.fileURL)
        
        
        
        
        do{
             _ = try Realm()
           
        }catch{
            print("Error initialising realm")
        }
        
        
        return true
    }


    
    
   


}

