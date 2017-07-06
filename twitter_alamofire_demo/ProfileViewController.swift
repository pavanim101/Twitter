//
//  ProfileViewController.swift
//  twitter_alamofire_demo
//
//  Created by Pavani Malli on 7/5/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var backdropImageView: UIImageView!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var userTweetsTableView: UITableView!
    
    @IBOutlet weak var followingCount: UILabel!
    var tweet: Tweet!
    
    @IBOutlet weak var followerCountLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var currentUser: User! = User.current
    
    var tweets: [Tweet] = []
    
    var timelineID: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userTweetsTableView.dataSource = self
        userTweetsTableView.delegate = self
        
        userTweetsTableView.rowHeight = UITableViewAutomaticDimension
        userTweetsTableView.estimatedRowHeight = 100
        
        if tweet == nil {
            timelineID = String(currentUser.id)
            nameLabel.text = currentUser.name
            usernameLabel.text = "@" + currentUser.username
            descriptionLabel.text = currentUser.description
            followingCount.text = String(currentUser.followingCount)
            
            print(currentUser.followerCount)
            
            followerCountLabel.text = String(currentUser.followerCount)
            
            let profileURL = URL(string: currentUser.profileImageURL)
            profileImageView.af_setImage(withURL: profileURL!)
            
            
            if currentUser.backgroundImageURL != "" {
                let backdropURL = URL(string: currentUser.backgroundImageURL)
                backdropImageView.af_setImage(withURL: backdropURL!)
            }
            
            
        } else{
            timelineID = String(tweet.user.id)
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
        
        
        
        
        
        APIManager.shared.getUserTimeLine(completion: { (tweets, error) in
            if let tweets = tweets {
                self.tweets = tweets
                print(self.tweets)
                self.userTweetsTableView.reloadData()
            } else if let error = error {
                print("Error getting home timeline: " + error.localizedDescription)}}, userID: self.timelineID)

        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        
        cell.tweet = tweets[indexPath.row]
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}



