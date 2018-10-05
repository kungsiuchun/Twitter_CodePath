//
//  ProfileViewController.swift
//  twitter_alamofire_demo
//
//  Created by SiuChun Kung on 9/28/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
 
    
    
    @IBOutlet weak var ProfilePicImageView: UIImageView!
    
    @IBOutlet weak var userHandlerLabel: UILabel!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var followerCountLabel: UILabel!
    
    @IBOutlet weak var followingCountLabel: UILabel!
    
    @IBOutlet weak var TweetsCountLabel: UILabel!
    
    @IBOutlet weak var BackgroundImageView: UIImageView!
    
    var user: User!
    var tweets: [Tweet]!

    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        ProfilePicImageView.setImageWith(user.profileURL!)
        userHandlerLabel.text = ("@\(user.screenname!)")
        userNameLabel.text = user.name!
        
        let followers = (user.dict?["followers_count"] as? Int) ?? 0
        followerCountLabel.text = "\(followers)"
        
        let following = (user.dict?["friends_count"] as? Int) ?? 0
        followingCountLabel.text =  "\(following)"
        
        let tweets = (user.dict?["statuses_count"] as? Int) ?? 0
        TweetsCountLabel.text = "\(tweets)"
        
        let bg_img_str = user.dict?["profile_background_image_url_https"] as! String
        let background_image_url = URL(string: bg_img_str)
        
        BackgroundImageView.setImageWith(background_image_url!)
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        getHomeline()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    func getHomeline(){
        APIManager.shared.getHomeTimeLine { (allTweets: [Tweet]!, error) in
            
            self.tweets = allTweets
            // update table
            self.tableView.reloadData()
            print ("view appeared")
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
