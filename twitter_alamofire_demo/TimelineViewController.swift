//
//  TimelineViewController.swift
//  twitter_alamofire_demo
//
//  Created by Aristotle on 2018-08-11.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
    ,UIScrollViewDelegate, ComposeViewControllerDelegate {
    
    
    func did(post: Tweet) {
        self.getHomeline()
    }
    
     var isMoreDataLoading = false
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var refreshControl:UIRefreshControl!
    var tweets: [Tweet]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        tableView.delegate = self
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        self.activityIndicator.startAnimating()
        getHomeline()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func logout(_ sender: Any) {
        APIManager.shared.logout()
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (!isMoreDataLoading) {
            // Calculate the position of one screen length before the bottom of the results
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            // When the user has scrolled past the threshold, start requesting
            if(scrollView.contentOffset.y > scrollOffsetThreshold && tableView.isDragging) {
                isMoreDataLoading = true
                // Code to load more results
                self.tableView.insertSubview(refreshControl, at: 0)
            }
        }
    }
    
 func getHomeline(){
            APIManager.shared.getHomeTimeLine { (allTweets: [Tweet]!, error) in
            self.tweets = allTweets
            // update table
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
            self.refreshControl.endRefreshing()
            print ("view appeared")
            if let error = error {
                    print("Error geeting home timeline: " + error.localizedDescription)
                }
        }
    }
    
    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        APIManager.shared.getNewHomeTimeLine{ (tweets, error) in
            if let tweets = tweets {
                self.tweets = tweets
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
                self.activityIndicator.stopAnimating()
            }else if let error = error {
                print("Error geeting home timeline: " + error.localizedDescription)
            }
        }
        self.refreshControl.endRefreshing()
        self.activityIndicator.stopAnimating()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.tweets != nil {
            return tweets.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetCell
        cell.tweet = tweets[indexPath.row]
        cell.selectionStyle = .none
        
        return cell
        
    }
    
    @IBAction func onImageClick(_ sender: Any) {
        self.performSegue(withIdentifier: "userViewSegue", sender: sender)
    }
    
    @IBAction func onCompose(_ sender: Any) {
        print ("Composing")
        self.performSegue(withIdentifier: "replySegue", sender: sender)
    }
    
    @IBAction func onProfile(_ sender: Any) {
        self.performSegue(withIdentifier: "profileViewSegue", sender: sender)
    }
    
    
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "toDetailViewSegue" {
            let cell = sender as! UITableViewCell
            // get the indexpath for the given cell
            let indexPath = tableView.indexPath(for: cell)
            // get the movie
            let current_tweet = self.tweets![(indexPath!.row)]
            // get the detail view controller we segue to
            let detailViewControl = segue.destination as! TweetDetailViewController
            // add to the dictionary in the custom class
            detailViewControl.tweet = current_tweet
            print("Segue to details")
        }
        
        if segue.identifier == "userViewSegue" {
            var indexPath: NSIndexPath!
            
            if let button = sender as? UIButton {
                if let superview = button.superview {
                    if let cell = superview.superview as? TweetCell {
                        indexPath = tableView.indexPath(for: cell) as NSIndexPath?
                    }
                }
            }
            let tweet = self.tweets[indexPath.row]
            let profileViewControl = segue.destination as! ProfileViewController
            profileViewControl.user = User(dict: tweet.userDictionary)
        }
        
        if segue.identifier == "replySegue" {
            let controller = segue.destination as! ReplyViewController
            controller.delegate = self
            controller.reply = false
            controller.user = User.currentUser
            print ("reply Segue")
        }
        
        if segue.identifier == "profileViewSegue" {
            let controller = segue.destination as! ProfileViewController
            controller.user = User.currentUser
            print ("profileViewSegue Segue")
        }
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
