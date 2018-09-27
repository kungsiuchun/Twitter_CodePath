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
    var screenName: String?
    
    init(dictionary: [String: Any]) {
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
    }

}
