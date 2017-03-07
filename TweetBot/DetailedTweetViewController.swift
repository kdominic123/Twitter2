//
//  DetailedTweetViewController.swift
//  TweetBot
//
//  Created by Avinash Singh on 06/03/17.
//  Copyright © 2017 Kenan Dominic. All rights reserved.
//

import UIKit

class DetailedTweetViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var retweetsCountLabel: UILabel!
    @IBOutlet weak var favoritesCountLabel: UILabel!
    @IBOutlet weak var retweetsImageLabel: UIImageView!
    @IBOutlet weak var favoritesImageLabel: UIImageView!
    
    var tweet: Tweet?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        profileImageView.setImageWith(URL(string: tweet!.imageProfile!)!)
        nameLabel.text = tweet!.name!
        handleLabel.text = "@" + tweet!.screenname!
        textLabel.text = tweet!.text!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE MMM d HH:mm"
        let date = dateFormatter.string(from: tweet!.time!) as String!
        
        timeLabel.text = date
        retweetsCountLabel.text = "\(tweet!.retweetCount)"
        favoritesCountLabel.text = "\(tweet!.favoritesCount)"
        
        
        if(tweet!.favorited)!{
            self.favoritesImageLabel.image = UIImage(named: "favor-icon-1")
        }
        else
        {
            self.favoritesImageLabel.image = UIImage(named: "favor-icon")
        }
        
        if(tweet!.retweeted!)
        {self.retweetsImageLabel.image = UIImage(named: "retweet-icon-green")
        }
        else
        {
            self.retweetsImageLabel.image = UIImage(named: "retweet-icon")
        }
        
    }
    
    
    @IBAction func retweetButton(_ sender: Any) {
        
        print("Function1 entered")
     
        TwitterClient.sharedInstance?.retweet(id: (self.tweet?.id_str!)!, success: { (response: Tweet) in
            
            print("retweeted")
            self.retweetsImageLabel.image = UIImage(named: "retweet-icon-green")
            self.retweetsCountLabel.text = "\(response.retweetCount)"
            self.tweet!.retweetCount = response.retweetCount
            self.tweet!.retweeted = true
        }, faliure: { (error: Error) in
            
            TwitterClient.sharedInstance?.unretweet(id: (self.tweet?.id_str!)!, success: { (response: Tweet) in
                
                print("unretweeted")
                self.retweetsImageLabel.image = UIImage(named: "retweet-icon")
                self.retweetsCountLabel.text = "\(response.retweetCount-1)"
                self.tweet!.retweetCount = response.retweetCount
                self.tweet!.retweeted = false
            }, faliure: { (error: Error) in
            
            })
        })
    }
    
    @IBAction func favoriteButton(_ sender: Any) {
        
        TwitterClient.sharedInstance?.favorite(id: tweet!.id_str!, success: { (response: Tweet) in
            self.favoritesImageLabel.image = UIImage(named: "favor-icon-1")
            self.favoritesCountLabel.text = "\(response.favoritesCount)"
            self.tweet!.favoritesCount = response.favoritesCount
            self.tweet!.favorited = response.favorited
            //self.tweet!.favorited = true
        }, faliure: { (error: Error) in
            
            TwitterClient.sharedInstance?.unfavorite(id: self.tweet!.id_str!, success: { (response: Tweet) in
                self.favoritesImageLabel.image = UIImage(named: "favor-icon")
                self.favoritesCountLabel.text = "\(response.favoritesCount)"
                self.tweet!.favoritesCount = response.favoritesCount
                self.tweet!.favorited = response.favorited
            }, faliure: { (error: Error) in
                //NOTHING TO BE IMPLEMENTED
            })
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let replyViewController = segue.destination as! ReplyViewController
        replyViewController.tweet = self.tweet
    }
 }

