//
//  ViewController.swift
//  PhotoDownloader
//
//  Created by Dmitry on 26.02.22.
//

import UIKit
import NVActivityIndicatorView
import NVActivityIndicatorViewExtended

class SlideshowViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicatorView = imageView.initActivityIndicatorView(indicatorWidth: 50,
                                                                    indicatorHeight: 50)
        setDefaultImage()
        activityIndicatorView?.startAnimating()
        startTimer()
    }
    
    private var timer: Timer?
    private var activityIndicatorView: NVActivityIndicatorView?
    private var placeHolder = UIImage(named: Constants.defaultImage)
    private var randomeURL: String? {
        Constants.stringArrayURL.randomElement()
    }
    
    @IBOutlet weak var stopSlideshowButton: UIButton!
    @IBOutlet weak var playSlideshowButton: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func showImagesGaleryAction(_ sender: Any) {
        stopTimer()
    }
    
    @IBAction func playSlideshowAction(_ sender: Any) {
        startTimer()
    }
    
    @IBAction func showNextImageAction(_ sender: Any) {
        if timer != nil {
            stopTimer()
        }
        reloadImage()
    }
    
    @IBAction func stopSlideshowAction(_ sender: Any) {
        stopTimer()
    }
    
    private func startTimer() {
        toggleButtonsOn()
        
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(reloadImage), userInfo: nil, repeats: true)
    }
    
    @objc func reloadImage() {
        setDefaultImage()
        activityIndicatorView?.startAnimating()
        downloadImage()
    }
    
    private func stopTimer() {
        toggleButtonsOff()
        
        timer?.invalidate()
        timer = nil
    }
    
    private func showAlert(textError: String) {
        let alert = UIAlertController(title: Constants.titleAlert,
                                      message: Constants.messageAlert + textError,
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: Constants.resumeSlideshowAlertAction,
                                      style: UIAlertAction.Style.default,
                                      handler: { (action: UIAlertAction) in
            self.activityIndicatorView?.startAnimating()
            self.startTimer()
        }))
        alert.addAction(UIAlertAction(title: Constants.showNextImageAlertAction,
                                      style: UIAlertAction.Style.default,
                                      handler: { (action: UIAlertAction) in
            self.activityIndicatorView?.startAnimating()
            self.downloadImage()
        }))
        alert.addAction(UIAlertAction(title: Constants.cancelAlertAction,
                                      style: UIAlertAction.Style.cancel))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private func toggleButtonsOn() {
        playSlideshowButton.isEnabled = false
        stopSlideshowButton.isEnabled = true
    }
    
    private func toggleButtonsOff() {
        playSlideshowButton.isEnabled = true
        stopSlideshowButton.isEnabled = false
    }
    
    private func setDefaultImage() {
        imageView.image = UIImage(named: Constants.defaultImage)
    }
    
    private func downloadImage() {
        activityIndicatorView?.startAnimating()
        
        guard let randomeURL = randomeURL else { return }
        
        let imageDownloader = ImageDownloader()
        
        imageDownloader.imageFromServerURL(from: randomeURL,
                                           completionHandlerError: completionHandlerError(error:),
                                           completionHandlerSuccess: completionHandlerSuccess(image:))
    }
    
    private func completionHandlerError(error: Error) -> () {
        stopTimer()
        showAlert(textError: error.localizedDescription)
        self.activityIndicatorView?.stopAnimating()
    }
    
    private func completionHandlerSuccess(image: UIImage?) -> () {
        self.activityIndicatorView?.stopAnimating()
        if let image = image {
            imageView.image = image
        } else {
            imageView.image = placeHolder
        }
    }
}

