//
//  ProfileViewController.swift
//  twitter_alamofire_demo
//
//  Created by Pavani Malli on 7/5/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var backdropImageView: UIImageView!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var userTweetsTableView: UITableView!
    
    @IBOutlet weak var followingCount: UILabel!
    var tweet: Tweet!
    
    
    @IBOutlet weak var followerCountLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if tweet == nil {
        
        
            
            
            
            
            
            
        
        
        } else{
        nameLabel.text = tweet.user.name
        usernameLabel.text = "@" + tweet.user.username
        descriptionLabel.text = tweet.user.description
        followingCount.text = String(tweet.user.followingCount)
        
        print(tweet.user.followerCount)
       
        followerCountLabel.text = String(tweet.user.followerCount)
            
        
        
        
        let profileURL = URL(string: tweet.user.profileImageURL)
        profileImageView.af_setImage(withURL: profileURL!)
        
        if tweet.user.backgroundImageURL != nil {
        let backdropURL = URL(string: tweet.user.backgroundImageURL)
        backdropImageView.af_setImage(withURL: backdropURL!)
            
            
        }
    }
        
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
    
    
    


}
