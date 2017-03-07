//
//  ReplyViewController.swift
//  TweetBot
//
//  Created by Avinash Singh on 06/03/17.
//  Copyright © 2017 Kenan Dominic. All rights reserved.
//

import UIKit

class ReplyViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var replyTextView: UITextView!
    
    var tweet: Tweet?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let tweet = tweet {
            
            replyTextView.text = "@\(tweet.screenname!)"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onSendButton(_ sender: Any) {
        
        print("Send was pressed")
        
        TwitterClient.sharedInstance?.reply(id: (tweet?.id_str)!, text: replyTextView.text!, success: { (response: Tweet) in
            
            print(self.replyTextView.text!)
            self.navigationController!.popViewController(animated: true)
            
        }, faliure: { (error: Error) in
            
            let errorAlertController = UIAlertController(title: "Error!", message: error.localizedDescription, preferredStyle: .alert)
            let errorAction = UIAlertAction(title: "Ok", style: .default) { (action) in
                
            }
            errorAlertController.addAction(errorAction)
            self.present(errorAlertController, animated: true)
            
        })
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
