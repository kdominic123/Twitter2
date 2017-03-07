//
//  TweetsViewController.swift
//  TweetBot
//
//  Created by Kenan Dominic on 2/27/17.
//  Copyright © 2017 Kenan Dominic. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TweetTableViewCellDelegate {

    @IBOutlet weak var tableView: UITableView!
    var tweets: [Tweet]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 125
        
        // Do any additional setup after loading the view.
        
        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets: [Tweet]) in
            
            self.tweets = tweets
            self.tableView.reloadData()
            
        }, failure: { (error: NSError) in
            
            print(error.localizedDescription)
        })
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogoutAction(_ sender: Any) {
        
        let logoutAlert = UIAlertController(title: "Logout", message: "Are you sure you want to logout?", preferredStyle: UIAlertControllerStyle.alert)
        
        logoutAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
            
            TwitterClient.sharedInstance?.logout()
        }))
        
        logoutAlert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (action: UIAlertAction!) in
            
        }))
        
        present(logoutAlert, animated: true, completion: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let tweets = tweets {
            
            return tweets.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetTableViewCell
        
        cell.tweet = tweets![indexPath.row]
        cell.delegate = self
        
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let cell = sender as? UITableViewCell {
            
            let indexPath =  tableView.indexPath(for: cell)
            let tweet = tweets[indexPath!.row]
            let detailedTweetViewController = segue.destination as! DetailedTweetViewController
            detailedTweetViewController.tweet = tweet
        }
        

        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "loadList"), object: nil, queue: OperationQueue.main) { (Notification) in
            
            self.tableView.reloadData()
        }
    }
    
    func showUserProfile(cell: TweetTableViewCell, user: User){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let profileVC = storyboard.instantiateViewController(withIdentifier: "UsersProfileViewController") as? UsersProfileViewController {
            profileVC.user = user
            self.navigationController?.pushViewController(profileVC, animated: true)
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
