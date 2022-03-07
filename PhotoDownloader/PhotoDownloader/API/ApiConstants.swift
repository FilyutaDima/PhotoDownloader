//
//  ApiConstants.swift
//  PhotoDownloader
//
//  Created by Dmitry on 2.03.22.
//

import Foundation

class ApiConstants {
    static let serverPath = "http://localhost:3000/"
    static let remoteUsersUrl = URL(string: "http://jsonplaceholder.typicode.com/users")
    
    static let postsPath = serverPath + "posts"
    static let postsPathURL = URL(string: postsPath)
    
    static let albumsPath = serverPath + "albums"
    static let albumsPathURL = URL(string: albumsPath)
    
    static let photosPath = serverPath + "photos"
    static let photosPathURL = URL(string: photosPath)
    
    static let commentsPath = serverPath + "comments"
    static let commentsPathURL = URL(string: commentsPath)
    
    
}
