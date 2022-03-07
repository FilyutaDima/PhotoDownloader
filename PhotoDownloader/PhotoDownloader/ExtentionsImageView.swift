//
//  ExtentionsImageView.swift
//  PhotoDownloader
//
//  Created by Dmitry on 7.03.22.
//

import UIKit
import NVActivityIndicatorView
import NVActivityIndicatorViewExtended

extension UIImageView: NVActivityIndicatorViewable {
    
    private func presentingIndicatorTypes() -> [NVActivityIndicatorType] {
        return NVActivityIndicatorType.allCases.filter { $0 != .blank }
    }
    
    func initActivityIndicatorView(indicatorWidth: Int,
                                   indicatorHeight: Int) -> NVActivityIndicatorView {
        
        
        let x = Int(self.frame.minX + self.frame.width / 2) - indicatorWidth / 2
        let y = Int(self.frame.minY + self.frame.height / 2) - indicatorHeight / 2
        
        let indicatorType = presentingIndicatorTypes()[23]
        let frame = CGRect(x: x, y: y, width: indicatorWidth, height: indicatorHeight)
        
        let activityIndicatorView = NVActivityIndicatorView(frame: frame,type: indicatorType)
        self.addSubview(activityIndicatorView)
        
        return activityIndicatorView
    }
}
