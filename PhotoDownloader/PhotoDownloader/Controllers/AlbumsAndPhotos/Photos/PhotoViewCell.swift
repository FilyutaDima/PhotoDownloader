//
//  PhotoViewCell.swift
//  PhotoDownloader
//
//  Created by Dmitry on 6.03.22.
//

import UIKit
import Alamofire
import AlamofireImage
import NVActivityIndicatorView
import NVActivityIndicatorViewExtended

class PhotoViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    var photo: Photo?
    private var activityIndivator: NVActivityIndicatorView?
    
    func configureCell() {
        photoImageView.image = UIImage(named: Constants.defaultImage)
    }
    
    func startActivityAnimation() {
        activityIndivator = photoImageView.initActivityIndicatorView(indicatorWidth: 30,
                                                                     indicatorHeight: 30)
        activityIndivator?.startAnimating()
    }
    
    func stopActivityAnimation() {
        activityIndivator?.stopAnimating()
    }
    
    func getThumbnail() {
        if let photo = photo,
           let thumbnailURL = photo.thumbnailUrl {
            
            if let image = CacheManager.shared.imageCache.image(withIdentifier: thumbnailURL) {
                photoImageView.image = image
            } else {
                AF.request(thumbnailURL).responseImage(completionHandler: { [weak self] response in
                    if case .success(let image) = response.result {
                        self?.photoImageView.image = image
                        self?.stopActivityAnimation()
                    }
                })
            }
        }
    }
}
