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
    
    @IBOutlet weak var feedControl: UISegmentedControl!
    
    var currentUser: User! = User.current
    
    var tweets: [Tweet] = []
    
    var timelineID: String!
    
    var user: User!
    
    
    @IBOutlet weak var headerView: UIView!
    
    
    @IBAction func onChange(_ sender: UISegmentedControl) {
        switch feedControl.selectedSegmentIndex
        {
        case 0:
            APIManager.shared.getUserTimeLine(completion: { (tweets, error) in
                if let tweets = tweets {
                    self.tweets = tweets
                    print(self.tweets)
                    self.userTweetsTableView.reloadData()
                } else if let error = error {
                    print("Error getting home timeline: " + error.localizedDescription)}}, userID: self.timelineID)

        case 2:
            APIManager.shared.getFavorites(completion: { (tweets, error) in
                if let tweets = tweets {
                    self.tweets = tweets
                    print(self.tweets)
                    self.userTweetsTableView.reloadData()
                } else if let error = error {
                    print("Error getting home timeline: " + error.localizedDescription)}
            }, userID: self.timelineID)
            
        
        default:
            break
        }
}
        
        
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userTweetsTableView.dataSource = self
        userTweetsTableView.delegate = self
        
        userTweetsTableView.tableHeaderView = headerView
        
        userTweetsTableView.rowHeight = UITableViewAutomaticDimension
        userTweetsTableView.estimatedRowHeight = 100
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        
        userTweetsTableView.insertSubview(refreshControl, at: 0)
        
        
        if tweet == nil {
            loadData(user: currentUser)
            
        } else{
            loadData(user: tweet.user)
            
        }
        
        APIManager.shared.getUserTimeLine(completion: { (tweets, error) in
            if let tweets = tweets {
                self.tweets = tweets
                print(self.tweets)
                self.userTweetsTableView.reloadData()
            } else if let error = error {
                print("Error getting home timeline: " + error.localizedDescription)}}, userID: self.timelineID)
        
        
    }
    
    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        
        
        if feedControl.selectedSegmentIndex == 0 {
        APIManager.shared.getUserTimeLine(completion: { (tweets, error) in
            if let tweets = tweets {
                self.tweets = tweets
                print(self.tweets)
                self.userTweetsTableView.reloadData()
                refreshControl.endRefreshing()
            } else if let error = error {
                print("Error getting home timeline: " + error.localizedDescription)}}, userID: self.timelineID)
        } else if feedControl.selectedSegmentIndex == 2 {
            APIManager.shared.getFavorites(completion: { (tweets, error) in
                if let tweets = tweets {
                    self.tweets = tweets
                    print(self.tweets)
                    self.userTweetsTableView.reloadData()
                    self.userTweetsTableView.reloadData()
                } else if let error = error {
                    print("Error getting home timeline: " + error.localizedDescription)}
            }, userID: self.timelineID)
            
            
            
        }
        
    }
    
    
    
    
    func loadData(user: User) {
        timelineID = String(user.id)
        nameLabel.text = user.name
        usernameLabel.text = "@" + user.username
        descriptionLabel.text = user.description
        followingCount.text = String(user.followingCount)
        
        print(user.followerCount)
        
        followerCountLabel.text = String(user.followerCount)
        
        let profileURL = URL(string: user.profileImageURL)
        profileImageView.af_setImage(withURL: profileURL!)
        self.profileImageView.layer.borderWidth=1.0
        self.profileImageView.layer.borderColor = UIColor.white.cgColor
        self.profileImageView.layer.masksToBounds = false
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.height/2
        self.profileImageView.clipsToBounds = true
        
        
        
        if user.backgroundImageURL != "" {
            print(user.backgroundImageURL)
            let backdropURL = URL(string: user.backgroundImageURL)
            backdropImageView.af_setImage(withURL: backdropURL!)
        }
        
        
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



