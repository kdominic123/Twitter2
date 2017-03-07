//
//  TweetTableViewCell.swift
//  TweetBot
//
//  Created by Kenan Dominic on 2/27/17.
//  Copyright © 2017 Kenan Dominic. All rights reserved.
//

import UIKit


protocol TweetTableViewCellDelegate: class  {
    func showUserProfile(cell: TweetTableViewCell, user: User)
}

class TweetTableViewCell: UITableViewCell {

    var dict: NSDictionary?
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var retweetImageView: UIImageView!
    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    var delegate: TweetTableViewCellDelegate?
    
    var tweet: Tweet! {
      
        willSet {
            
            nameLabel.text = newValue.name!
            screennameLabel.text = "@\(newValue.screenname!)"
            tweetTextLabel.text = newValue.text!
            profileImage.setImageWith(URL(string: newValue.imageProfile!)!)
        
            let timeAgo = Int(Date().timeIntervalSince(newValue.time!))
            let ago = convertSecondToDateAgo(seconds: timeAgo)
            
            timeLabel.text = ago
            
            let favoriteCountString = convertCount(count: newValue.favoritesCount)
            let retweetCountString = convertCount(count: newValue.retweetCount)
            
            retweetCountLabel.text = retweetCountString
            favoriteCountLabel.text = favoriteCountString
            
            if(newValue.favorited)! {
                self.favoriteImageView.image = UIImage(named: "favor-icon-1")
            } else {
                self.favoriteImageView.image = UIImage(named: "favor-icon")
            }
            
            if(newValue.retweeted)! {
                self.retweetImageView.image = UIImage(named: "retweet-icon-green")
            } else {
                self.retweetImageView.image = UIImage(named: "retweet-icon")
            }
            
            let cellTapRecognizerRetweet = UITapGestureRecognizer(target: self, action: #selector(TweetTableViewCell.onTapRetweet(_:)))
            cellTapRecognizerRetweet.cancelsTouchesInView = true
            retweetImageView.addGestureRecognizer(cellTapRecognizerRetweet)
            
            let cellTapRecognizerFavorite = UITapGestureRecognizer(target: self, action: #selector(TweetTableViewCell.onTapFavorite(_:)))
            cellTapRecognizerFavorite.cancelsTouchesInView = true
            favoriteImageView.addGestureRecognizer(cellTapRecognizerFavorite)
        }
        didSet {
            //do nothing
        }
    }
    
    func convertSecondToDateAgo(seconds: Int) -> String {
        var result: String?
        
        if(seconds/60 <= 59) {
            result = "\(seconds/60) m"
        } else if (seconds/3600 <= 23) {
            result = "\(seconds/3600) h"
        } else {
            result = "\(seconds/216000) d"
        }
        return result!
    }
    
    func convertCount(count: Int) -> String {
        var result: String?
        
        if(count/1000 >= 1 && count/1000 <= 100) {
            result = "\(count/1000)K"
        } else if(count/1000000 >= 1) {
            result = "\(count/1000000)M"
        } else {
            result = "\(count)"
        }
        
        return result!
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func onTapRetweet(_ sender: Any) {
        print("tapped retweet")
        TwitterClient.sharedInstance?.retweet(id: tweet.id_str!, success: { (response: Tweet) in
            print(response.text!)
            print("retweet begin")
            self.retweetImageView.image = UIImage(named: "retweet-icon-green")
            self.retweetCountLabel.text = self.convertCount(count: response.retweetCount)
            self.tweet.retweetCount = response.retweetCount
            self.tweet.retweeted = true
        }, faliure: { (error: Error) in
            print(error.localizedDescription)
            print("already retweeted")
            TwitterClient.sharedInstance?.unretweet(id: self.tweet.id_str!, success: { (response: Tweet) in
                self.retweetImageView.image = UIImage(named: "retweet-icon")
                self.retweetCountLabel.text = self.convertCount(count: response.retweetCount - 1)
                self.tweet.retweetCount = response.retweetCount
                self.tweet.retweeted = false
                print("unretweeted")
            }, faliure: { (error: Error) in
                //nothing
            })
        })
    }
    
    func onTapFavorite(_ sender: Any) {
        
        TwitterClient.sharedInstance?.favorite(id: tweet.id_str!, success: { (response: Tweet) in
            print(response.text!)
            print("Liked")
            self.favoriteImageView.image = UIImage(named: "favor-icon-1")
            self.favoriteCountLabel.text = self.convertCount(count: response.favoritesCount)
            self.tweet.favoritesCount = response.favoritesCount
            self.tweet.favorited = response.favorited
        }, faliure: { (error: Error) in
            print(error.localizedDescription)
            print("already liked")
            TwitterClient.sharedInstance?.unfavorite(id: self.tweet.id_str!, success: { (response: Tweet) in
                self.favoriteImageView.image = UIImage(named: "favor-icon")
                self.favoriteCountLabel.text = self.convertCount(count: response.favoritesCount)
                self.tweet.favoritesCount = response.favoritesCount
                self.tweet.favorited = response.favorited
            }, faliure: { (error: Error) in
                //nothing
            })
        })
    }
    
    @IBAction func showUserProfile(_ sender: Any) {
        
        if let delegate = delegate{
            delegate.showUserProfile(cell: self, user: self.tweet.user!)
        }
        else{
            print("delegate = nil")
        }
    }
    
    
}
