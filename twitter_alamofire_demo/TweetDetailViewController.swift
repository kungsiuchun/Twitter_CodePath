//
//  TweetDetailViewController.swift
//  twitter_alamofire_demo
//
//  Created by SiuChun Kung on 9/28/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var userhandleLabel: UILabel!
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    @IBOutlet weak var tweetCreatedOnLabel: UILabel!
    
    @IBOutlet weak var tweetCreatedTimeLabel: UILabel!
    
    @IBOutlet weak var countRetweetLabel: UILabel!
    
    @IBOutlet weak var countFavoritesLabel: UILabel!
    
    @IBOutlet weak var userPictureImage: UIImageView!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBOutlet weak var retweetButton: UIButton!
    
    var tweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if tweet.name != nil {
        usernameLabel.text = tweet.name
        }
        userhandleLabel.text = tweet.username
        tweetTextLabel.text = tweet.text
        tweetCreatedOnLabel.text = tweet.createdAtString
        if let timeStamp = tweet.timeStamp {
            tweetCreatedTimeLabel.text = APIManager.timeSince(timeStamp: timeStamp as Date)
        }
        
        
        if let cnt = tweet.favoritesCount{
            countFavoritesLabel.text = String(cnt)
        }
        else{
            countFavoritesLabel.text = String(0)
        }
        if let cnt = tweet.retweetCount{
            countRetweetLabel.text = String(cnt)
        }
        else{
            countRetweetLabel.text = String(0)
        }

        userPictureImage.setImageWith(tweet.imageUrl as URL)
        userPictureImage.layer.cornerRadius = 3
        userPictureImage.clipsToBounds = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onRetweet(_ sender: Any) {
        if(!(tweet.retweet!)){
            let image = UIImage(named: "retweet-icon-green")
            retweetButton.setImage(image, for: UIControlState.normal)
            tweet.retweet = true
            APIManager.shared.retweet(tweet) { (ntweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error retweet tweet: \(error.localizedDescription)")
                } else if let ntweet = ntweet {
                    print("Successfully retweet the following Tweet")
                    let count = ntweet.retweetCount!
                    self.countRetweetLabel.text = String(count)
                }
            }
        }else {
            let image = UIImage(named: "retweet-icon")
            retweetButton.setImage(image, for: UIControlState.normal)
            tweet.retweet = false
            APIManager.shared.unretweet(tweet) { (ntweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unretweet tweet: \(error.localizedDescription)")
                } else if let ntweet = ntweet {
                    print("Successfully unretweet the following Tweet")
                    let count = ntweet.retweetCount!
                    self.countRetweetLabel.text = String(count)
                }
            }
        }
    }
    
    @IBAction func onFavorite(_ sender: Any) {
        if(!(tweet.favorite!)){
            let image = UIImage(named: "favor-icon-red")
            favoriteButton.setImage(image, for: UIControlState.normal)
            tweet.favorite = true
            APIManager.shared.favorite(tweet) { (ntweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let ntweet = ntweet {
                    print("Successfully favorited the following Tweet")
                    let count = ntweet.favoritesCount!
                    self.countFavoritesLabel.text = String(count)
                }
            }
        }else {
            let image = UIImage(named: "favor-icon")
            favoriteButton.setImage(image, for: UIControlState.normal)
            tweet.favorite = false
            APIManager.shared.unfavorite(tweet) { (ntweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unfavoriting tweet: \(error.localizedDescription)")
                } else if let ntweet = ntweet {
                    print("Successfully unfavorited the following Tweet")
                    let count = ntweet.favoritesCount!
                    self.countFavoritesLabel.text = String(count)
                }
            }
        }
    }
    
    @IBAction func onReply(_ sender: Any) {
         self.performSegue(withIdentifier: "replySegue", sender: sender)
    }
    
//    var indexPath: NSIndexPath!
//
//    if let button = sender as? UIButton {
//        if let superview = button.superview {
//            if let cell = superview.superview as? TweetCell {
//                indexPath = tableView.indexPath(for: cell) as NSIndexPath?
//            }
//        }
//    }
//    let tweet = self.tweets[indexPath.row]
//
//    let profileViewControl = segue.destination as! ProfileViewController
//
//    profileViewControl.user = User(dict: tweet.userDictionary)
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "replySegue" {
            print ("in replySegue")
            let controller = segue.destination as! ReplyViewController
            // give tweet info to the next page
            // send this tweet info
            controller.tweet = self.tweet
            controller.user = User(dict: tweet.userDictionary)
            
            // set that this is in reply to a status
            controller.reply = true
            print ("to reply Segue")
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
