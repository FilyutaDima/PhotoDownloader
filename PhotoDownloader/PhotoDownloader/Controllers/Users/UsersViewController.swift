//
//  UserViewController.swift
//  PhotoDownloader
//
//  Created by Dmitry on 3.03.22.
//

import UIKit

class UsersViewController: UITableViewController {

    
    private var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func fetchData() {
        guard let url = ApiConstants.remoteUsersUrl else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }

            do {
                self.users = try JSONDecoder().decode([User].self, from: data)
            } catch let error {
                print(error)
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        task.resume()
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        performSegue(withIdentifier: Constants.showDetail, sender: user)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.reuseIdentifier,
                                                 for: indexPath) as! UserViewCell
        let user = users[indexPath.row]
        cell.configure(with: user)

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController,
           let user = sender as? User {
            destination.user = user
        }
    }
    

}
