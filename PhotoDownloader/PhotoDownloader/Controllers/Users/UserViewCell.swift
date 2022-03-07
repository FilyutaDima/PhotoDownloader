//
//  UserViewCell.swift
//  PhotoDownloader
//
//  Created by Dmitry on 2.03.22.
//

import UIKit

class UserViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    func configure(with user: User) {
        nameLabel.text = user.name
        emailLabel.text = user.email
    }
}
