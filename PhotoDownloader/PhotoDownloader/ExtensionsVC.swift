//
//  ExtensionsViewController.swift
//  PhotoDownloader
//
//  Created by Dmitry on 1.03.22.
//

import UIKit
import NVActivityIndicatorView
import NVActivityIndicatorViewExtended

extension ViewController: NVActivityIndicatorViewable {
    
    private func presentingIndicatorTypes() -> [NVActivityIndicatorType] {
        return NVActivityIndicatorType.allCases.filter { $0 != .blank }
    }
    
    func initActivityIndicatorView(into view: UIView,
                                   indicatorWidth: Int,
                                   indicatorHeight: Int) -> NVActivityIndicatorView {
        
        let x = Int(view.frame.minX + view.frame.width / 2) - indicatorWidth / 2
        let y = Int(view.frame.minY + view.frame.height / 2) - indicatorHeight / 2
        
        let indicatorType = presentingIndicatorTypes()[23]
        let frame = CGRect(x: x, y: y, width: indicatorWidth, height: indicatorHeight)
        
        let activityIndicatorView = NVActivityIndicatorView(frame: frame,type: indicatorType)
        view.addSubview(activityIndicatorView)
        
        return activityIndicatorView
    }
}
