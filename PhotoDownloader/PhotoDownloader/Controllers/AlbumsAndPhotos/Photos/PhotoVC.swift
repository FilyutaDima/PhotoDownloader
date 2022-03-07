//
//  PhotoVC.swift
//  PhotoDownloader
//
//  Created by Dmitry on 7.03.22.
//

import UIKit
import Alamofire
import AlamofireImage
import NVActivityIndicatorView
import NVActivityIndicatorViewExtended

class PhotoVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        startActivityAnimation()
        configureImageView()
        getPhoto()
    }
    
    var currentPhotoURL: String?
    var currentPhotoTitle: String?
    private var activityIndivator: NVActivityIndicatorView?
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    private func getPhoto() {
        if let url = currentPhotoURL,
           let title = currentPhotoTitle {
            
            if let image = CacheManager.shared.imageCache.image(withIdentifier: url) {
                photoImageView.image = image
            } else {
                AF.request(url).responseImage(completionHandler: { [weak self] response in
                    if case .success(let image) = response.result {
                        self?.photoImageView.image = image
                        self?.titleLabel.text = title
                        self?.stopActivityAnimation()
                    }
                })
            }
        }
    }
    
    private func configureImageView() {
        photoImageView.image = UIImage(named: Constants.defaultImage)
    }
    
    private func startActivityAnimation() {
        activityIndivator = photoImageView.initActivityIndicatorView(indicatorWidth: 30,
                                                                     indicatorHeight: 30)
        activityIndivator?.startAnimating()
    }
    
    private func stopActivityAnimation() {
        activityIndivator?.stopAnimating()
    }
}
