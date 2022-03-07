//
//  PhotosCVC.swift
//  PhotoDownloader
//
//  Created by Dmitry on 6.03.22.
//

import UIKit
import Alamofire
import AlamofireImage

class PhotosCVC: UICollectionViewController {
    
    var photos = [Photo]()
    var currentAlbumID: Int?

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.reuseIdentifier, for: indexPath) as! PhotoViewCell
    
        cell.configureCell()
        cell.startActivityAnimation()
        cell.photo = photos[indexPath.item]
        cell.getThumbnail()
    
        return cell
    }
    
    func getPhotos() {
        if let currentAlbumID = currentAlbumID {
            let pathURL = "\(ApiConstants.photosPath)?albumId=\(currentAlbumID)"
            guard let url = URL(string: pathURL) else { return }
            
            AF.request(url).response { response in
                if case .success(let data) = response.result,
                   let data = data {
                    do {
                        self.photos = try JSONDecoder().decode([Photo].self, from: data)
                        self.collectionView.reloadData()
                    } catch let error {
                        print(error)
                    }
                }
            }
        }
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.showPhoto, sender: photos[indexPath.item])
    }
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.showPhoto,
           let photo = sender as? Photo,
           let photoVC = segue.destination as? PhotoVC {
            
            photoVC.currentPhotoURL = photo.url
            photoVC.currentPhotoTitle = photo.title
        }
    }
}

extension PhotosCVC : UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        let itemsPerRow: CGFloat = 2
        let paddingWidth = 5 * (itemsPerRow + 1)
        let avaibleWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = avaibleWidth / itemsPerRow

        return CGSize(width: widthPerItem, height: widthPerItem)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}

