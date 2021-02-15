//
//  DatabaseManager.swift
//  TikTok
//
//  Created by Tayyab on 10/02/2021.
//

import Foundation
import FirebaseDatabase


final class DatabaseManager {
    
   public static let shared = DatabaseManager()
    private let database = Database.database().reference()
    
    
    private init() {}
    
    //public
    
   public func getAllUsers(completion: ([String])-> ()) {
        
        
        
        
    }
}

