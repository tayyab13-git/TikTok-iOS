//
//  ExplorePostViewModel.swift
//  TikTok
//
//  Created by Tayyab on 22/02/2021.
//

import Foundation
import UIKit

struct ExplorePostViewModel {
    
    let thumbnail: UIImage?
    let title: String
    let handler: (() -> Void)
}
