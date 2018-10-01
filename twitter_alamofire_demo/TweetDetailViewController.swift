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
        // tweetCreatedOnLabel.text = tweet.timeStamp as Date
        // tweetCreatedTimeLabel.text =
        
        if (tweet.favorite == true) {
            favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: .normal)
        } else {
            favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon"), for: .normal)
        }
        countRetweetLabel.text = String(tweet.retweetCount)
        
        
        if (tweet.retweet == true) {
            retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: .normal)
        } else {
            retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon"), for: .normal)
        }
        countFavoritesLabel.text = String(tweet.favoritesCount)
        
        
        userPictureImage.setImageWith(tweet.imageUrl as URL)
        userPictureImage.layer.cornerRadius = 3
        userPictureImage.clipsToBounds = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onRetweet(_ sender: Any) {
    }
    
    @IBAction func onFavorite(_ sender: Any) {
    }
    
    @IBAction func onReply(_ sender: Any) {
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
