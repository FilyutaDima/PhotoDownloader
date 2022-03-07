//
//  DetailViewController.swift
//  PhotoDownloader
//
//  Created by Dmitry on 3.03.22.
//

import UIKit

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUIWidthData()
    }
    
    var user: User?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    
    private func setupUIWidthData() {
        
        guard let user = user,
              let address = user.address,
              let company = user.company,
              let geo = address.geo else { return }
        
        nameLabel.text = user.name
        usernameLabel.text = user.username
        emailLabel.text = user.email
        phoneNumberLabel.text = user.phone
        websiteLabel.text = user.website
        addressLabel.text = """
                            suite: \(address.suite ?? ""),
                            city: \(address.city ?? ""),
                            zipcode: \(address.zipcode ?? ""),
                            latitude: \(geo.lat ?? ""),
                            longitude: \(geo.lng ?? "")
                            """
        companyLabel.text = """
                            name: \(company.name ?? ""),
                            bs: \(company.bs ?? ""),
                            catchPhrase: \(company.catchPhrase ?? "")"
                            """
    }
    
    
    @IBAction func postsActionButton(_ sender: Any) {
        performSegue(withIdentifier: Constants.showPosts, sender: user)
    }
    @IBAction func albumsActionButton(_ sender: Any) {
        performSegue(withIdentifier: Constants.showAlbums, sender: user)
    }
    @IBAction func showMapActionButton(_ sender: Any) {
        guard let user = user,
              let address = user.address,
              let geo = address.geo else { return }
        
        performSegue(withIdentifier: Constants.showMap, sender: geo)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.showPosts,
           let postsVC = segue.destination as? PostsTableViewController,
           let user = sender as? User {
            postsVC.currentUserID = user.id
            postsVC.getPosts()
        } else if segue.identifier == Constants.showAlbums,
                  let albumsVC = segue.destination as? AlbumsTVC,
                  let user = sender as? User {
            albumsVC.currentUserID = user.id
            albumsVC.getAlbums()
        } else if segue.identifier == Constants.showMap,
                  let mapVC = segue.destination as? MapVC,
                  let geo = sender as? Geo {
            mapVC.geo = geo
        }
    }
    

}
