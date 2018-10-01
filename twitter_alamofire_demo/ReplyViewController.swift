//
//  ReplyViewController.swift
//  twitter_alamofire_demo
//
//  Created by SiuChun Kung on 9/30/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class ReplyViewController: UIViewController {
    
    var tweet: Tweet!
    var reply: Bool!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var profieImage: UIImageView!
    @IBOutlet weak var usernameHandle: UILabel!
    @IBOutlet weak var tweetTextField: UITextField!
    
    var user: User!
    

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
