//
//  PostComment.swift
//  TikTok
//
//  Created by Tayyab on 17/02/2021.
//

import Foundation


struct PostComment {
    
    let text: String
    let user: User
    let date: Date
    
    static func mockComment() -> [PostComment] {
        
        let user = User(name: "Tayyab", profilePictureURL: nil, identifier: UUID().uuidString)
        
        var comments = [PostComment]()
        
        let text = [
            
            "This is awsome",
            "This is lad",
            "I'm learning so much!"
        ]
        
        for comment in text {
            
            comments.append(PostComment(text: comment, user: user, date: Date()))
        }
        return comments
        
    }
}
