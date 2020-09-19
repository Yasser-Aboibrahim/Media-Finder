//
//  UserDefaultsManager.swift
//  Media Finder X
//
//  Created by yasser on 8/13/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import Foundation
// Singleton
class UserDefaultManager {
    
   private static let sharedInstance = UserDefaultManager()
    
    private init() {}
    
   static func shared() -> UserDefaultManager{
        return UserDefaultManager.sharedInstance
    }
    //_____________________________________________
    //ViewController flag
    var isLoggedIn: Bool {
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.isLoggedIn)
        }
        get{
            return UserDefaults.standard.bool(forKey: UserDefaultsKeys.isLoggedIn)
        }
    }
    //____________________________________________
    // UserData

    var userEmail: String? {
    set{
    UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.userEmail)
    }
    get{
        return UserDefaults.standard.object(forKey: UserDefaultsKeys.userEmail) as? String
    }
    }

}


