//
//  TimelineViewController.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
// TODO:  clickable links, relative time, infinite scorlling, char count, connect to detail 

import UIKit

class TimelineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ComposeViewControllerDelegate, UIScrollViewDelegate {
    
    var tweets: [Tweet] = []
    
    var isMoreDataLoading = false;
    var queryLimit: Int = 20
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        
        tableView.insertSubview(refreshControl, at: 0)
    
        
        APIManager.shared.getHomeTimeLine(completion: {(tweets, error) in
            if let tweets = tweets {
                self.tweets = tweets
                print(self.tweets)
                self.tableView.reloadData()
            } else if let error = error {
                print("Error getting home timeline: " + error.localizedDescription)
            }}, count: self.queryLimit)
        
        self.isMoreDataLoading = false
    
    
    }
    
    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        APIManager.shared.getHomeTimeLine(completion: {(tweets, error) in
        if let tweets = tweets {
                self.tweets = tweets
                print(self.tweets)
                self.tableView.reloadData()
                 refreshControl.endRefreshing()
            } else if let error = error {
                print("Error getting home timeline: " + error.localizedDescription)
            }}, count: self.queryLimit)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (!isMoreDataLoading){
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            
            if(scrollView.contentOffset.y > scrollOffsetThreshold && tableView.isDragging) {
                isMoreDataLoading = true
                self.queryLimit += 20
                APIManager.shared.getHomeTimeLine(completion: {(tweets, error) in
                    if let tweets = tweets {
                        self.tweets = tweets
                        print(self.tweets)
                        self.tableView.reloadData()
                    } else if let error = error {
                        print("Error getting home timeline: " + error.localizedDescription)
                    }}, count: self.queryLimit)
                
                self.isMoreDataLoading = false

                
            }
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
        
    }
    
    
    @IBAction func didTapLogout(_ sender: Any) {
        APIManager.shared.logout()
    }
    
    func did(post: Tweet) {
       tweets.insert(post, at: 0)
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: [IndexPath.init(row: 0, section: 0)], with: .automatic)
        self.tableView.endUpdates()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "composeTweet" {
        let composeViewController = segue.destination as! ComposeViewController
        composeViewController.delegate = self
        }
        else if segue.identifier == "tweetDetail" {
            let cell = sender as! TweetCell
            if let indexPath = tableView.indexPath(for: cell){
                let tweet = tweets[indexPath.row]
                let tweetDetailViewController = segue.destination as! DetailViewController
                tweetDetailViewController.tweet = tweet
                tweetDetailViewController.row = indexPath.row
                print("assigned data")
        }
     
        }
    }

}
