//
//  ExploreManager.swift
//  TikTok
//
//  Created by Tayyab on 24/02/2021.
//

import Foundation
import UIKit


final class ExploreManager {
    
    static let shared = ExploreManager()
    
    
    public func getExploreBanner() -> [ExploreBannerViewModel] {
        
        guard let data = parseExploreData() else {return []}
        
       return data.banners.compactMap({
            
            ExploreBannerViewModel(image: UIImage(named: $0.image), title: $0.title, handler: {
                
            })
          }
        )
    }
    
    public func getExplorePosts() -> [ExplorePostViewModel] {
        
        guard let data = parseExploreData() else {return []}
        
        return data.trendingPosts.compactMap({
            
            ExplorePostViewModel(thumbnail: UIImage(named: $0.image), title: $0.caption) {
                //empty
            }
        })
    }
    
    public func getExploreHashTag() -> [ExploreHashTagViewModel] {
        
        guard let data = parseExploreData() else {return []}
        
        return data.hashtags.compactMap({
            
            ExploreHashTagViewModel(icon: UIImage(named: $0.image), text: $0.tag, count: $0.count) {
                
            }
        })
    }
    
    public func getExploreUser() -> [ExploreUserViewModel] {
        
        guard let data =  parseExploreData() else {return []}
        
        return data.creators.compactMap({
            
            ExploreUserViewModel(profilePictureUrl: URL(string: $0.image), username: $0.username, followerCount: $0.followers_count) {
                
            }
        })
        
    }
    
    private func parseExploreData() -> ExploreResponse? {
        
        guard let path = Bundle.main.path(forResource: "explore", ofType: "json") else {return nil}
        
        let url = URL(fileURLWithPath: path)
        
        do {
            let data = try Data(contentsOf: url)
            
            return try JSONDecoder().decode(ExploreResponse.self, from: data)
        }
        catch
        {
            print(error)
            return nil
        }
        
    }
    
}

struct ExploreResponse: Codable {
    
    let banners: [Banner]
    let trendingPosts: [Posts]
    let creators: [Creators]
    let recentPosts: [Posts]
    let hashtags: [HashTags]
    let popular: [Posts]
    let recommended: [Posts]
}

struct Banner: Codable {
    
    let id: String
    let image: String
    let title: String
    let action: String
    
}

struct Posts: Codable {
    
    let id: String
    let image: String
    let caption: String
}

struct Creators: Codable {
    
    let id: String
    let image: String
    let username: String
    let followers_count: Int
}

struct HashTags: Codable {
    
    let image: String
    let tag: String
    let count: Int
    
}
