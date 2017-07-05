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
    
    var tweet: Tweet!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let tweet = tweet {
            nameLabel.text = tweet.user.name
            usernameLabel.text = "@" + tweet.user.username
            
            let profileURL = URL(string: tweet.user.profileImageURL)
            
            profileImageView.af_setImage(withURL: profileURL!)
            
            tweetTextLabel.text = tweet.text
            timestampLabel.text = tweet.createdAtString
            retweetCountLabel.text = String(tweet.retweetCount)
            likeCountLabel.text = String(tweet.favoriteCount)

            
        }
    
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
