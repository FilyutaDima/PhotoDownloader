//
//  ExtensionsImageView.swift
//  PhotoDownloader
//
//  Created by Dmitry on 28.02.22.
//

import Foundation
import UIKit

extension UIImageView {
    
    func imageFromServerURL(_ URLString: String,
                            placeHolder: UIImage?,
                            completionHandlerError: ((Error) -> ())?,
                            completionHandlerSuccess: (() -> ())?) {
        self.image = nil
        
        if let url = URL(string: URLString) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                DispatchQueue.main.async { [self] in
                    
                    if let error = error {
                        
                        if let completionHandlerError = completionHandlerError {
                            completionHandlerError(error)
                        }
                        
                        image = nil
                        self.image = placeHolder
                        
                        
                    }
                    
                    if let data = data,
                       let image = UIImage(data: data) {
                        
                        if let completionHandlerSuccess = completionHandlerSuccess {
                            completionHandlerSuccess()
                        }
                        
                        self.image = image
                        
                    } else {
                        
                        self.image = placeHolder
                        image = nil
                    }
                }
            }.resume()
        }
    }
}
