//
//  ExploreCells.swift
//  TikTok
//
//  Created by Tayyab on 22/02/2021.
//

import Foundation
import UIKit

enum ExploreCells {
    
    case banner(viewModel: ExploreBannerViewModel)
    case post(viewModel: ExplorePostViewModel)
    case hashtag(viewModel: ExploreHashTagViewModel)
    case user(viewModel: ExploreUserViewModel)
    
}
