//
//  ExploreUserViewModel.swift
//  TikTok
//
//  Created by Tayyab on 22/02/2021.
//

import Foundation
import UIKit

struct ExploreUserViewModel {
    
    let profilePictureUrl: URL?
    let username: String
    let followerCount: Int
    let handler: (() -> Void)
}

