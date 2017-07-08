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
    
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var retweetButton: UIButton!
    
        
    var tweet: Tweet! {
        didSet {
            self.refreshData()
            
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
        
    
    @IBAction func didLike(_ sender: UIButton) {
        if tweet.favorited == false {
            tweet.favorited = true
            tweet.favoriteCount += 1
        
            refreshData()

            APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }
            
        } else {
            tweet.favorited = false
            tweet.favoriteCount -= 1
            
            refreshData()
            
            APIManager.shared.unfavorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unfavoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unfavorited the following Tweet: \n\(tweet.text)")
                }
            }
        }
        
    }
    
    
    @IBAction func didRetweet(_ sender: UIButton) {
        if tweet.retweeted == false {
            tweet.retweeted = true
            tweet.retweetCount += 1
            
            refreshData()
            
            APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error retweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully retweeted the following Tweet: \n\(tweet.text)")
                }
            }
        }else {
            print("unretweet starting")
            tweet.retweeted = false
            tweet.retweetCount -= 1
            
            refreshData()
            
            APIManager.shared.unretweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unfavoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unfavorited the following Tweet: \n\(tweet.text)")
                }
            }
        }

    }
    
    
    func refreshData() {
        retweetButton.isSelected = tweet.retweeted
        likeButton.isSelected = tweet.favorited!
        tweetTextLabel.text = tweet.text
        nameLabel.text = tweet.user.name
        usernameLabel.text = "@" + tweet.user.username
        retweetCountLabel.text = String(tweet.retweetCount)
        favoriteCountLabel.text = String(tweet.favoriteCount)
        timestampLabel.text = tweet.createdAtString
        
        let profileURL = URL(string: tweet.user.profileImageURL)!
        profileImageView.af_setImage(withURL: profileURL)
        self.profileImageView.layer.borderWidth=1.0
        self.profileImageView.layer.borderColor = UIColor.white.cgColor
        self.profileImageView.layer.masksToBounds = false
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.height/2
        self.profileImageView.clipsToBounds = true
        
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
 
    }
    
}
