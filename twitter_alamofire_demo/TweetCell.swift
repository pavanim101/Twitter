//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage


class TweetCell: UITableViewCell {
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
        
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var timestampLabel: UILabel!
    
    @IBOutlet weak var retweetCountLabel: UILabel!
    
    @IBOutlet weak var favoriteCountLabel: UILabel!
    
    var tweet: Tweet! {
        didSet {
            tweetTextLabel.text = tweet.text
            nameLabel.text = tweet.user.name
            usernameLabel.text = "@" + tweet.user.username
            retweetCountLabel.text = String(tweet.retweetCount)
            favoriteCountLabel.text = String(tweet.favoriteCount)
            timestampLabel.text = tweet.createdAtString
            
            let profileURL = URL(string: tweet.user.profileImageURL)!
            print("setting image")
            print(profileURL)
            profileImageView.af_setImage(withURL: profileURL)
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
