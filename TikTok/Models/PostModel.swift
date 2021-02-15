//
//  PostModel.swift
//  TikTok
//
//  Created by Tayyab on 15/02/2021.
//

import Foundation

struct PostModel {
    
    let identifier: String
    
    static func mockModel() -> [PostModel] {
        
        var posts = [PostModel]()
        
        for _ in 0...100 {
            
            let post = PostModel(identifier: UUID().uuidString)
            posts.append(post)
            
        }
        return posts
    }
}
