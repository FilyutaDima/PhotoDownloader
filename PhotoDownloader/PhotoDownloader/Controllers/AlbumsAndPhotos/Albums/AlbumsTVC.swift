//
//  AlbumsTVC.swift
//  PhotoDownloader
//
//  Created by Dmitry on 6.03.22.
//

import UIKit
import Alamofire
import SwiftyJSON

class AlbumsTVC: UITableViewController {
    
    var currentUserID: Int?
    var albums = [JSON]()

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.reuseIdentifier, for: indexPath) as! AlbumViewCell
        
        let title = albums[indexPath.item][Constants.title].stringValue
        cell.titleLabel.text = title
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(albums[indexPath.item])
        performSegue(withIdentifier: Constants.showPhotos,
                     sender: albums[indexPath.item][Constants.id].intValue)
    }
    
    func getAlbums() {
        
        if let currentUserID = currentUserID {
            
            let pathUrl = "\(ApiConstants.albumsPath)?userId=\(currentUserID)"
            guard let url = URL(string: pathUrl) else { return }
        
            AF.request(url).response { response in
                switch response.result {
                case .success(let data):
                    self.albums = JSON(data).arrayValue
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.showPhotos,
           let photosCVC = segue.destination as? PhotosCVC,
           let albumID = sender as? Int {
            photosCVC.currentAlbumID = albumID
            photosCVC.getPhotos()
        }
    }
}
