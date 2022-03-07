//
//  ImageDownloader.swift
//  PhotoDownloader
//
//  Created by Dmitry on 1.03.22.
//

import UIKit

class ImageDownloader {
    
    func imageFromServerURL(from URLString: String,
                            completionHandlerError: ((Error) -> ())?,
                            completionHandlerSuccess: ((UIImage?) -> ())?) {
        
        if let url = URL(string: URLString) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                DispatchQueue.main.async {
                    
                    if let error = error {
                        
                        if let completionHandlerError = completionHandlerError {
                            completionHandlerError(error)
                        }
                    }
                    
                    if let data = data,
                       let image = UIImage(data: data) {
                        
                        if let completionHandlerSuccess = completionHandlerSuccess {
                            completionHandlerSuccess(image)
                        }
                        
                    } else {
                        
                        if let completionHandlerSuccess = completionHandlerSuccess {
                            completionHandlerSuccess(nil)
                        }
                    }
                }
            }.resume()
        }
    }
}
