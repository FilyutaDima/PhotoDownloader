//
//  PostsTableViewController.swift
//  PhotoDownloader
//
//  Created by Dmitry on 3.03.22.
//

import UIKit

class PostsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    var currentUserID: Int?
    var posts: [Post] = []
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.reuseIdentifier) as! PostTableViewCell
        
        let post = posts[indexPath.row]
        cell.postTitle.text = post.title
        cell.postBody.text = post.body
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.showComments, sender: posts[indexPath.item].id)
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    @IBAction func unwindToPostTableViewController(_ unwindSegue: UIStoryboardSegue) {}
    
    func getPosts() {
        guard let userId = currentUserID else { return }
        let pathUrl = "\(ApiConstants.postsPath)?userId=\(userId)"
        
        guard let url = URL(string: pathUrl) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            
            do {
                self.posts = try JSONDecoder().decode([Post].self, from: data)
            } catch let error {
                print(error)
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        task.resume()
    }
    
    private func updateData() {
        getPosts()
    }
    
    @objc private func addTapped() {
        performSegue(withIdentifier: Constants.addPost, sender: currentUserID)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.showComments,
           let commentsVC = segue.destination as? CommentsTableViewController,
           let currentPostId = sender as? Int {
            
            commentsVC.currentPostId = currentPostId
            commentsVC.getComments()
            
        } else if segue.identifier == Constants.addPost,
           let addPostVC = segue.destination as? AddPostViewController,
           let currentUserID = sender as? Int {
            
            addPostVC.currentUserId = currentUserID
            addPostVC.updatePosts = {
                self.updateData()
            }
            
        }
    }
}
