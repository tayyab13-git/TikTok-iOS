//
//  ExploreHashTagViewModel.swift
//  TikTok
//
//  Created by Tayyab on 22/02/2021.
//

import Foundation
import UIKit

struct ExploreHashTagViewModel {
    
    let icon: UIImage?
    let text: String
    let count: Int
    let handler: (() -> Void)
}
