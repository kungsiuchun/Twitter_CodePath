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

    
    var tweet : Tweet! {
        didSet {
            
            thumbnailImageView.setImageWith(tweet.imageUrl as URL)
            displayNameLabel.text = tweet.name
            tweetText.text = tweet.text
            usernameLabel.text = "@\(tweet.username)"
            
            if let cnt = tweet.favoritesCount{
                favoriteCount.text = String(cnt)
            }
//            else{
//                favoriteCount.text = String(0)
//            }
            if let cnt = tweet.retweetCount{
                retweetCount.text = String(cnt)
            }
//            else{
//                retweetCount.text = String(0)
//            }
            
            // for time label
            if let timeStamp = tweet.timeStamp {
                timeStampLabel.text = APIManager.timeSince(timeStamp: timeStamp as Date)
            }
            
        }
    }
    
    
    @IBAction func tapLove(_ sender: Any) {
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
                    self.favoriteCount.text = String(count)
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
                    self.favoriteCount.text = String(count)
                }
            }
        }
        
    }
    
    
    @IBAction func tapRetweet(_ sender: Any){
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
                    self.retweetCount.text = String(count)
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
                    self.retweetCount.text = String(count)
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
