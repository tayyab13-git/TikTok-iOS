//
//  AuthenticationManager.swift
//  TikTok
//
//  Created by Tayyab on 10/02/2021.
//

import Foundation
import FirebaseAuth

enum SignInMethod {
    
    case email
    case google
    case facebook
    
}


final class AuthManager {
    
   public static let shared = AuthManager()
    
    private init() {}
    
    //public
    
    public func signIn(with method: SignInMethod) {
        
        
        
    }
    
    public func signout() {
        
        
        
    }

}
