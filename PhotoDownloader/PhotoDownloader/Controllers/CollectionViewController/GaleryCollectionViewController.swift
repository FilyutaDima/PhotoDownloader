//
//  GaleryCollectionViewController.swift
//  PhotoDownloader
//
//  Created by Dmitry on 27.02.22.
//

import UIKit
import NVActivityIndicatorView
import NVActivityIndicatorViewExtended

class GaleryCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private var activityIndicatorView: NVActivityIndicatorView?
    private var placeHolder = UIImage(named: Constants.defaultImage)

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return Constants.stringArrayURL.count
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.reuseIdentifier,
                                                      for: indexPath) as! ImageViewCell
        
//        activityIndicatorView = initActivityIndicatorView(into: cell.imageView,
//                                                          indicatorWidth: 20,
//                                                          indicatorHeight: 20)
//        activityIndicatorView?.startAnimating()
        
        cell.imageView.imageFromServerURL(Constants.stringArrayURL[indexPath.item],
                                          placeHolder: placeHolder,
                                          completionHandlerError: nil,
                                          completionHandlerSuccess: nil)
        return cell
    }
    
//    private func completionHandlerSuccess(image: UIImage) -> () {
//        self.activityIndicatorView?.stopAnimating()
//    }
}

extension GaleryCollectionViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        let itemsPerRow: CGFloat = 2
        let paddingWidth = 10 * (itemsPerRow + 1)
        let avaibleWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = avaibleWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
