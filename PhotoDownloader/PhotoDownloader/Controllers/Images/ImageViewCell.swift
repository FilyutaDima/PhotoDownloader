//
//  ImageViewCell.swift
//  PhotoDownloader
//
//  Created by Dmitry on 27.02.22.
//

import UIKit
import NVActivityIndicatorView
import NVActivityIndicatorViewExtended

class ImageViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var currentPhotoIndex: Int?
    private var activityIndicatorView: NVActivityIndicatorView?
    private let placeHolder = UIImage(named: Constants.defaultImage)
    
    func configureActivityIndicator() {
        activityIndicatorView = imageView.initActivityIndicatorView(indicatorWidth: 30,
                                                          indicatorHeight: 30)
    }
    
    func startActivityIndicator() {
        configureActivityIndicator()
        activityIndicatorView?.startAnimating()
    }
    
    func stopActivityIndicator() {
        activityIndicatorView?.stopAnimating()
    }
    
    func getPhoto() {
        
        guard let currentPhotoIndex = currentPhotoIndex else { return }
        
        let imageDownloader = ImageDownloader()
        let stringURL = Constants.stringArrayURL[currentPhotoIndex]
        let placeHolder = UIImage(named: Constants.defaultImage)
        
        imageDownloader.imageFromServerURL(from: stringURL,
                                           completionHandlerError: { error in
            self.stopActivityIndicator()
            self.imageView.image = placeHolder
        },
                                           completionHandlerSuccess: { image in
            self.stopActivityIndicator()
            
            if let image = image {
                self.imageView.image = image
            } else {
                self.imageView.image = placeHolder
            }
        })
    }
}
