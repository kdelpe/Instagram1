//
//  FeedViewController.swift
//  Instagram
//
//  Created by Kervens Delpe on 10/6/21.
//

import UIKit
import Parse
import AlamofireImage
import RSKPlaceholderTextView

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    var posts = [PFObject]()
    
    var currentUser = PFUser.current()
    
    let myRefreshControl = UIRefreshControl()
    
    var numberofPosts = Int()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadPosts()

        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        myRefreshControl.addTarget(self, action: #selector(loadPosts), for: .valueChanged)
        self.tableView.refreshControl = myRefreshControl
        tableView.rowHeight = 469
        tableView.estimatedRowHeight = 469
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loadMorePosts()
    }
    
    @objc func loadPosts(){
        numberofPosts = 20
        let query = PFQuery(className:"Posts")
        query.includeKey("author")
        query.limit = numberofPosts
        
        query.findObjectsInBackground { (posts, error) in
            if posts != nil {
                self.posts.removeAll()
                self.posts = posts!
                self.posts.reverse()
                self.tableView.reloadData()
                self.myRefreshControl.endRefreshing()
            } else {
                print("Error: \(String(describing: error?.localizedDescription))")
            }
        }
    }
    func loadMorePosts(){
        numberofPosts += 20
        let query = PFQuery(className:"Posts")
        query.includeKey("author")
        query.limit = numberofPosts
        
        query.findObjectsInBackground { (posts, error) in
            if posts != nil {
                self.posts.removeAll()
                self.posts = posts!
                self.posts.reverse()
                self.tableView.reloadData()
            } else {
                print("Error: \(String(describing: error?.localizedDescription))")
            }
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if indexPath.row + 1 == posts.count {
    loadMorePosts()
    }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        
        let post = posts[indexPath.row]
        
        let user = post["author"] as! PFUser
        cell.usernameLabel.text = user.username
        
        cell.captionLabel.text = post["caption"] as? String
        
        let imageFile = post["image"] as! PFFileObject
        
        let urlString = imageFile.url!
        
        let url = URL(string: urlString)!
        
        cell.photoView.af_setImage(withURL: url)
        
        return cell
    }
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
