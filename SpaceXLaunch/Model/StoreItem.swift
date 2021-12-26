//
//  StoreItem.swift
//  SpaceXLaunch
//
//  Created by Kyle Lei on 2021/12/25.
//

import Foundation

struct SearchResponse: Codable {
    let links: Link    
    let details: String
    let name: String
    let date_unix: Date    
       
    struct Link: Codable {
        let patch: Patch
        let reddit: Reddit
        let flickr: Flickr?
        let presskit: URL?
        let webcast: URL
        let youtube_id: String
        let article: URL?
                
        struct Patch: Codable {
            let small: URL
            let large: URL
        }
        struct Reddit: Codable {
            let launch: String
        }
        struct Flickr: Codable {
            let small: [URL]
            let original: [URL]
        }
    }
}
