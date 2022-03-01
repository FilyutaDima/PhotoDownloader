//
//  LaunchScreenViewController.swift
//  PhotoDownloader
//
//  Created by Dmitry on 27.02.22.
//

import UIKit
import NVActivityIndicatorView
import NVActivityIndicatorViewExtended

class LaunchScreenVC: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        startAnimation()
    }
    
    private let presentingIndicatorTypes = {
        return NVActivityIndicatorType.allCases.filter { $0 != .blank }
    }()
    
    private func startAnimation() {
        let size = CGSize(width: 30, height: 30)
        let indicatorType = presentingIndicatorTypes[17]
        startAnimating(size, message: "", type: indicatorType, fadeInAnimation: nil)
    }
    deinit {
        self.stopAnimating()
    }
}
