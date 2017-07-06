//
//  User.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/17/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import Foundation

class User {
    
    var name: String
    var dictionary: [String: Any]?
    var username: String
    var profileImageURL: String!
    var backgroundImageURL: String!
    var containsBackground: Bool!
    var followerCount: Int!
    var followingCount: Int!
    var description: String!
    var id: Int!
    
    private static var _current: User?
    
    static var current: User? {
        get {
            if _current == nil {
                let defaults = UserDefaults.standard
                if let userData = defaults.data(forKey: "currentUserData") {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData, options: []) as! [String: Any]
                    _current = User(dictionary: dictionary)
                }
            }
            return _current
        }
        set (user) {
            _current = user
            let defaults = UserDefaults.standard
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                defaults.set(data, forKey: "currentUserData")
            } else {
                defaults.removeObject(forKey: "currentUserData")
            }
        }
    }
    
    
    init(dictionary: [String: Any]) {
        self.dictionary = dictionary
        self.name = dictionary["name"] as? String ?? ""
        self.username = dictionary["screen_name"] as? String ?? ""
        self.profileImageURL = dictionary["profile_image_url_https"] as? String ?? ""
        self.containsBackground = dictionary["profile_use_background_image"] as? Bool ?? false
        self.description = dictionary["description"] as? String ?? ""
        self.backgroundImageURL = dictionary["profile_banner_url"] as? String ?? ""
        self.followerCount = dictionary["followers_count"] as? Int ?? 0
        self.followingCount = dictionary["friends_count"] as? Int ?? 0
        self.id = dictionary["id"] as? Int ?? 0
        
        
    }
}
