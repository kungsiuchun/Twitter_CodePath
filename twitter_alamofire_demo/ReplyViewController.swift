//
//  ReplyViewController.swift
//  twitter_alamofire_demo
//
//  Created by SiuChun Kung on 9/30/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

protocol ComposeViewControllerDelegate {
    func did(post: Tweet)
}
class ReplyViewController: UIViewController{
    
    var tweet: Tweet!
    var reply: Bool!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var profieImage: UIImageView!
    @IBOutlet weak var usernameHandle: UILabel!
    
    @IBOutlet weak var tweetTextField: UITextField!
    
    var user: User!
    var delegate: ComposeViewControllerDelegate?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        profieImage?.setImageWith(user.profileURL!)
        usernameHandle?.text = ("@\(user.screenname!)")
        usernameLabel?.text = user.name!
    
        
        let rightButton = UIBarButtonItem(title: "Send", style: UIBarButtonItemStyle.done, target: self, action: #selector(onSend(_:)))
        
        self.navigationItem.rightBarButtonItem = rightButton
        
        if reply == true {
            // set the name of the navigation controller
            self.title = self.tweet.name
            tweetTextField.text = "@\(tweet!.username) "
            tweetTextField.becomeFirstResponder()
        }
        else {
            // set the name of the navigation controller
            self.title = "Compose"
            print  ("this is a compose")
            tweetTextField.becomeFirstResponder()
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSend(_ sender: Any) {
         print ("Tweeted")
        let reply_id: String
        if self.reply == true {
            reply_id = tweetTextField.text!
        }
        else {
            reply_id = tweetTextField.text!
        }
        print ("\(reply_id)")
        APIManager.shared.composeTweet(with: reply_id) { (tweet, error) in
            if let error = error {
                print("Error composing Tweet: \(error.localizedDescription)")
                // also create a alert
                let errorAlertController = UIAlertController(title: "Error!", message: "\(error)", preferredStyle: .alert)
                        // add ok button
                let errorAction = UIAlertAction(title: "Ok", style: .default) { (action) in
                                //dismiss
                        }
                errorAlertController.addAction(errorAction)
                self.present(errorAlertController, animated: true)
                
            } else if let tweet = tweet {
                self.delegate?.did(post: tweet)
                print("Compose Tweet Success!")
                
                _ = self.navigationController!.popViewController(animated: true)
                
            }
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
