//
//  ProfileViewController.swift
//  TweetBot
//
//  Created by Avinash Singh on 06/03/17.
//  Copyright © 2017 Kenan Dominic. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var tweetsCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if User.currentUser != nil {
            
            profileImageView.setImageWith(User.currentUser!.profileURL!)
            coverImageView.setImageWith(User.currentUser!.coverURL!)
            nameLabel.text = User.currentUser!.name!
            handleLabel.text = "@" + (User.currentUser!.screenname!)
            tweetsCountLabel.text = "\(User.currentUser!.numOfTweets!)"
            followersCountLabel.text = "\(User.currentUser!.numOfFollowers!)"
            followingCountLabel.text = "\(User.currentUser!.numOfFollowing!)"
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
