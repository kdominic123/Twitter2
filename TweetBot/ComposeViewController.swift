//
//  ComposeViewController.swift
//  TweetBot
//
//  Created by Avinash Singh on 06/03/17.
//  Copyright © 2017 Kenan Dominic. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UITextViewDelegate {

    
    @IBOutlet weak var composeTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        composeTextView.becomeFirstResponder()
        composeTextView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTapSend(_ sender: Any) {
        
        print("Send pressed")
        
        TwitterClient.sharedInstance?.reply(id: "", text: self.composeTextView.text!, success: { (response: Tweet) in
            print(self.composeTextView.text!)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadList"), object: nil)
            self.navigationController!.popViewController(animated: true)
            
        }, faliure: { (error: Error) in
            
            let errorAlertController = UIAlertController(title: "Error!", message: "Tweet exceeded character limit", preferredStyle: .alert)
            let errorAction = UIAlertAction(title: "OK", style: .default) { (action) in
                //dismiss
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
