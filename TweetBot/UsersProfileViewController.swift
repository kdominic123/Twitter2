//
//  UsersProfileViewController.swift
//  TweetBot
//
//  Created by Avinash Singh on 07/03/17.
//  Copyright © 2017 Kenan Dominic. All rights reserved.
//

import UIKit

class UsersProfileViewController: UIViewController {

    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handeLabel: UILabel!
    @IBOutlet weak var tweetsCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    
    var user : User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        
        coverImageView.setImageWith(user!.coverURL!)
        profileImageView.setImageWith(user!.profileURL!)
        nameLabel.text = user!.name!
        handeLabel.text = "@\(user!.screenname!)"
        tweetsCountLabel.text = "\(user!.numOfTweets!)"
        followersCountLabel.text = "\(user!.numOfFollowers!)"
        followingCountLabel.text = "\(user!.numOfFollowing!)"
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
