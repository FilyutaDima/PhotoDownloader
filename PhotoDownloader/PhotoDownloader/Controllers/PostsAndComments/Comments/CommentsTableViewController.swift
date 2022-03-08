//
//  CommentsTableViewController.swift
//  PhotoDownloader
//
//  Created by Dmitry on 4.03.22.
//

import UIKit

class CommentsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
    }
    
    var currentPostId: Int?
    var comments = [Comment]()

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return comments.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.reuseIdentifier, for: indexPath) as! CommentTableViewCell
        
        let comment = comments[indexPath.item]
        cell.nameLabel.text = comment.name
        cell.bodyLabel.text = comment.body
        cell.emailLabel.text = comment.email
    
        return cell
    }

    func getComments() {
        guard let postId = currentPostId else { return }
        let pathUrl = "\(ApiConstants.commentsPath)?postId=\(postId)"
        
        guard let url = URL(string: pathUrl) else { return }
        print(pathUrl)
        let task = URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            
            do {
                self.comments = try JSONDecoder().decode([Comment].self, from: data)
            } catch let error {
                print(error)
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        task.resume()
    }
    
    @objc private func addTapped() {
        performSegue(withIdentifier: Constants.addComment, sender: currentPostId)
    }
    
    private func updateData() {
        getComments()
    }
    
    @IBAction func unwindToCommentsTVC(_ unwindSegue: UIStoryboardSegue) { }
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Constants.addComment,
           let addCommentVC = segue.destination as? AddCommentVC,
           let currentPostID = sender as? Int {
            
            addCommentVC.currentPostID = currentPostID
            addCommentVC.updateComments = {
                self.updateData()
            }
            
        }
    }
}
