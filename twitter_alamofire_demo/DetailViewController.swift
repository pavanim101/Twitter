//
//  DetailViewController.swift
//  twitter_alamofire_demo
//
//  Created by Pavani Malli on 7/5/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class DetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    @IBOutlet weak var timestampLabel: UILabel!
    
    @IBOutlet weak var retweetCountLabel: UILabel!
    
    @IBOutlet weak var likeCountLabel: UILabel!
    
    @IBOutlet weak var retweetButton: UIButton!
    
    @IBOutlet weak var likeButton: UIButton!
    
  
    var row: Int?
    
    var tweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        refreshData()
        
        
    }
    
    
    @IBAction func viewProfile(_ sender: UIButton) {
        self.usernameTapped()

    }
    
 
    func usernameTapped() {
        print("performing segue")
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func didRetweet(_ sender: UIButton) {
        print(tweet.retweeted)
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
        } else {
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let profileViewController = segue.destination as! ProfileViewController
        
            profileViewController.tweet = tweet
    }
    
 
 
    
    func refreshData() {
        if let tweet = tweet {
        retweetButton.isSelected = tweet.retweeted
        likeButton.isSelected = tweet.favorited!
        tweetTextLabel.text = tweet.text
        nameLabel.text = tweet.user.name
        usernameLabel.text = "@" + tweet.user.username
        retweetCountLabel.text = String(tweet.retweetCount)
        likeCountLabel.text = String(tweet.favoriteCount)
        timestampLabel.text = tweet.createdAtString
        
        let profileURL = URL(string: tweet.user.profileImageURL)!
        profileImageView.af_setImage(withURL: profileURL)
        
        }
    }
    
}
