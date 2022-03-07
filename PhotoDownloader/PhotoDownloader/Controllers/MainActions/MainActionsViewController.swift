//
//  MainViewController.swift
//  PhotoDownloader
//
//  Created by Dmitry on 3.03.22.
//

import UIKit

enum UserActions: String, CaseIterable {
    case downloadImage = "Download Image"
    case users = "Users"
}

class MainActionsViewControlller: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private let userActions = UserActions.allCases
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Constants.showUsers {
            let coursesVC = segue.destination as! UsersViewController
            coursesVC.fetchData()
        }
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return userActions.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserActionCell", for: indexPath) as! UserActionCell
        cell.userActionLabel.text = userActions[indexPath.item].rawValue
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userAction = userActions[indexPath.item]

        switch userAction {
        case .downloadImage:
            performSegue(withIdentifier: Constants.showImageDownloader, sender: self)
        case .users:
            performSegue(withIdentifier: Constants.showUsers, sender: self)
        }
    }
}

extension MainActionsViewControlller: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (UIScreen.main.bounds.width - 20), height: 80)
    }
}
