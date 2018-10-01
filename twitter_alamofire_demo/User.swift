//
//  User.swift
//  twitter_alamofire_demo
//
//  Created by SiuChun Kung on 9/26/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import Foundation

class User: NSObject {
    
    var name: String?
    var screenname: String?
    var profileURL: URL?
    var bio: String?
    var dict: NSDictionary?
    var printDict: NSDictionary?
    
    static var current: User?
    
    init(dict: NSDictionary) {
        // for putting in persistant memory as NSData
        self.dict = dict
        
        // for printing purpose only
        self.printDict = dict
        
        // deserialization: taking a dictionary of array of information and populating the needed information
        name = dict["name"] as? String
        screenname = dict["screen_name"] as? String
        let profileURLString = dict["profile_image_url_https"] as? String
        if let profileURLString = profileURLString {
            profileURL = URL(string: profileURLString)
        }
        
        bio = dict["description"] as? String
    }
    
    // for persistant memory about the info of the user
    class var currentUser: User? {
        get {
            if current == nil {
                // retrive the persistant key value pair called UserDefaults
                let defaults = UserDefaults.standard
                
                // get the currentUserData from the persistant memory (equivalent to cookie)
                let userData = defaults.object(forKey: "currentUserData") as? NSData
                
                if let userData = userData {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData as Data, options: [])
                    current = User(dict: dictionary as! NSDictionary)
                }
            }
            return current
        }
        
        set (user) {
            current = user
            let defaults = UserDefaults.standard
            
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dict!, options: [])
                
                defaults.set(data, forKey: "currentUserData")
            } else {
                defaults.removeObject(forKey: "currentUserData")
            }
            defaults.synchronize()
            
        }
    }
    
    static let userLoggedOutNotification = "UserLoggedOut"
    
    func printAll() {
        print(self.printDict ?? "nothing - samman")
    }

}
