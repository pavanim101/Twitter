//
//  Tweet.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import Foundation

class Tweet {
    
    // MARK: Properties
    var id: Int64 // For favoriting, retweeting & replying
    var text: String // Text content of tweet
    var favoriteCount: Int // Update favorite count label
    var favorited: Bool? // Configure favorite button
    var retweetCount: Int // Update favorite count label
    var retweeted: Bool // Configure retweet button
    var user: User // Contains name, screenname, etc. of tweet author
    var createdAtString: String // Display date
    var retweetedStatus: Tweet!
    var retweetedByUser: User?
    
    
    
    // MARK: - Create initializer with dictionary
    init(dictionary: [String: Any]) {
        var dictionary = dictionary
        
        id = dictionary["id"] as? Int64 ?? 0
        text = dictionary["text"] as? String ?? ""
        favoriteCount = dictionary["favorite_count"] as? Int ?? 0
        favorited = dictionary["favorited"] as? Bool ?? false
        retweetCount = dictionary["retweet_count"] as? Int ?? 0
        retweeted = dictionary["retweeted"] as? Bool ?? false
        retweetedStatus = dictionary["retweeted_status"] as? Tweet ?? nil
        
        if let originalTweet = dictionary["retweed_status"] as? [String: Any] {
            let userDictionary = dictionary["user"] as! [String: Any]
            self.retweetedByUser = User(dictionary: userDictionary)
            
            dictionary = originalTweet
        }
        
        let user = dictionary["user"] as? [String: Any] ?? [:]
        self.user = User(dictionary: user)
        
        
        let createdAtOriginalString = dictionary["created_at"] as! String
        let formatter = DateFormatter()
        // Configure the input format to parse the date string
        formatter.dateFormat = "E MMM d HH:mm:ss Z y"
        // Convert String to Date
        let date = formatter.date(from: createdAtOriginalString)!
        // Configure output format
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        // Convert Date to String
        createdAtString = formatter.string(from: date)
        
        
    }
}

