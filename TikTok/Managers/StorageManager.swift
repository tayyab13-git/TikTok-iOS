//
//  StorageManager.swift
//  TikTok
//
//  Created by Tayyab on 10/02/2021.
//

import Foundation
import FirebaseStorage


final class StorageManager {
    
   public static let shared = StorageManager()
    private let storage = Storage.storage().reference()
    
    
    private init() {}
    
    //public
    
    public func getVideoUrl(with identifier: String, completion: (URL) -> ()) {
        

    }
    
    public func uploadVideoUrl(from url: URL) {
        
        
    }
}
