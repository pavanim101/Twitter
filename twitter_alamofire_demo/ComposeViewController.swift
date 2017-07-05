//
//  ComposeViewController.swift
//  twitter_alamofire_demo
//
//  Created by Pavani Malli on 7/3/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import RSKPlaceholderTextView

protocol ComposeViewControllerDelegate: class {
    func did(post: Tweet)
}

class ComposeViewController: UIViewController {
    
    weak var delegate: ComposeViewControllerDelegate?
    
    @IBOutlet weak var composeTextView: RSKPlaceholderTextView!
    var textToPost: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        composeTextView.placeholder = "What's happening?"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func postTweet(_ sender: UIButton) {
        self.textToPost = composeTextView.text
        print(self.textToPost)
        APIManager.shared.composeTweet(with: self.textToPost) { (tweet, error) in
            if let error = error {
                print("Error composing Tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                self.delegate?.did(post: tweet)
                print("Compose Tweet Success!")
                self.composeTextView.text = ""
            }
        }
    }
    
    
    @IBAction func closeCompose(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
