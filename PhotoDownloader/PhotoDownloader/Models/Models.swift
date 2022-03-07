//
//  Models.swift
//  PhotoDownloader
//
//  Created by Dmitry on 2.03.22.
//

import Foundation

struct User: Decodable {
    let id: Int?
    let name: String?
    let username: String?
    let email: String?
    let phone: String?
    let website: String?
    let address: Address?
    let company: Company?
}

struct Address: Decodable {
    let street: String?
    let suite: String?
    let city: String?
    let zipcode: String?
    let geo: Geo?
}

struct Geo: Decodable {
    let lat: String?
    let lng: String?
}

struct Company: Decodable {
    let name: String?
    let catchPhrase: String?
    let bs: String?
}

struct Post: Decodable {
    let userId: Int?
    let id: Int?
    let title: String?
    let body: String?
}

struct Comment: Decodable {
    let postId: Int?
    let id: Int?
    let name: String?
    let email: String?
    let body: String?
}

struct Album {
    let userId: Int?
    let id: Int?
    let title: String?
}

struct Photo: Decodable {
    let albumId: Int?
    let id: Int?
    let title: String?
    let url: String?
    let thumbnailUrl: String?
}
