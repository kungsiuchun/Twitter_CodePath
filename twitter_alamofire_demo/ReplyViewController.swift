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
class ReplyViewController: UIViewController, UITextViewDelegate{
    
    var tweet: Tweet!
    var reply: Bool!
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profieImage: UIImageView!
    @IBOutlet weak var usernameHandle: UILabel!
    @IBOutlet weak var tweetTextField: UITextView!
    
    @IBOutlet weak var characterCountLabel: UILabel!
    var user: User!
    var delegate: ComposeViewControllerDelegate?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        profieImage?.setImageWith(user.profileURL!)
        usernameHandle?.text = ("@\(user.screenname!)")
        usernameLabel?.text = user.name!
        tweetTextField.delegate = self
        tweetTextField.isEditable = true
        
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
        APIManager.shared.composeTweet(with: tweetTextField.text!) { (tweet, error) in
            if let error = error {
                print("Error composing Tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                self.delegate?.did(post: tweet)
                print("Compose Tweet Success!")
                self.navigationController!.popViewController(animated: true)
            }
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // TODO: Check the proposed new text character count
        // Allow or disallow the new text
        // Set the max character limit
        let characterLimit = 140
        // Construct what the new text would be if we allowed the user's latest edit
        let newText = NSString(string: textView.text!).replacingCharacters(in: range, with: text)
        // TODO: Update Character Count Label
        characterCountLabel.text = String(characterLimit - newText.characters.count)
        // The new text should be allowed? True/False
        return newText.characters.count < characterLimit
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
