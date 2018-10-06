//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by SiuChun Kung on 9/27/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import Foundation
import AFNetworking

class TweetCell: UITableViewCell {


    @IBOutlet weak var thumbnailButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var favoriteCount: UILabel!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var displayNameLabel: UILabel!

    
    var retweetOn: Bool = false
    var favOn: Bool = false
    
    var tweet : Tweet! {
        didSet {
            
            thumbnailImageView.setImageWith(tweet.imageUrl as URL)
            displayNameLabel.text = tweet.name
            tweetText.text = tweet.text
            usernameLabel.text = "@\(tweet.username)"
            favoriteCount.text = String(tweet.favoritesCount)
            retweetCount.text = String(tweet.retweetCount)
            if tweet.favorite! {
                favOn = true
                let image = UIImage(named: "favor-icon-red")
                favoriteButton.setImage(image, for: UIControlState.normal)
            }else{
                favOn = false
            }
            if tweet.retweet!{
                retweetOn = true
                let image = UIImage(named: "retweet-icon-green")
                retweetButton.setImage(image, for: UIControlState.normal)
            }else{
                retweetOn = false
            }
            
            // for time label
            if let timeStamp = tweet.timeStamp {
                timeStampLabel.text = APIManager.timeSince(timeStamp: timeStamp as Date)
            }
            
        }
    }
    
    
    @IBAction func tapLove(_ sender: Any) {
        if(!favOn){
            let image = UIImage(named: "favor-icon-red")
            favoriteButton.setImage(image, for: UIControlState.normal)
            favOn = true
            tweet.favorite = true
            tweet.favoritesCount += 1
            APIManager.shared.favorite(tweet) { (ntweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else{
                    print("Successfully favorited the following Tweet")
                    self.favoriteCount.text = String(self.tweet.favoritesCount)
                }
            }
        }else {
            let image = UIImage(named: "favor-icon")
            favoriteButton.setImage(image, for: UIControlState.normal)
            favOn = false
            tweet.favorite = false
            tweet.favoritesCount -= 1
            APIManager.shared.unfavorite(tweet) { (ntweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unfavoriting tweet: \(error.localizedDescription)")
                } else{
                    print("Successfully unfavorited the following Tweet")
                  self.favoriteCount.text = String(self.tweet.favoritesCount)
                }
            }
        }
        
    }
    
    
    @IBAction func tapRetweet(_ sender: Any){
        if(!(retweetOn)){
            let image = UIImage(named: "retweet-icon-green")
            retweetButton.setImage(image, for: UIControlState.normal)
            retweetOn = true
            tweet.retweet = true
            tweet.retweetCount += 1
            APIManager.shared.retweet(tweet) { (ntweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error retweet tweet: \(error.localizedDescription)")
                } else {
                    print("Successfully retweet the following Tweet")
                  self.retweetCount.text = String(self.tweet.retweetCount)
                }
            }
        }else {
            let image = UIImage(named: "retweet-icon")
            retweetButton.setImage(image, for: UIControlState.normal)
            retweetOn = false
            tweet.retweet = false
            tweet.retweetCount -= 1
            APIManager.shared.unretweet(tweet) { (ntweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unretweet tweet: \(error.localizedDescription)")
                } else{
                    print("Successfully unretweet the following Tweet")
                  self.retweetCount.text = String(self.tweet.retweetCount)
                }
            }
        }
    }
    
    
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        thumbnailImageView.layer.cornerRadius = 3
        thumbnailImageView.clipsToBounds = true
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
