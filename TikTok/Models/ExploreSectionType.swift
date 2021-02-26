//
//  ExploreSectionType.swift
//  TikTok
//
//  Created by Tayyab on 22/02/2021.
//

import Foundation

enum ExploreSectionType {
    
    case banner
    case trendingPosts
    case user
    case trendingHashtags
    case recommended
    case popular
    case new
    
    var title: String {
        
        switch self {
        
        
        case .banner:
            return "Featured"
        case .trendingPosts:
            return "Trending Posts"
        case .user:
            return "Popular Creators"
        case .trendingHashtags:
            return "Hashtags"
        case .recommended:
            return "Recommended"
        case .popular:
            return "Popular"
        case .new:
            return "Recently Added"
        }
    }
}
