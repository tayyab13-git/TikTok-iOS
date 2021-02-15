//
//  HapticsManager.swift
//  TikTok
//
//  Created by Tayyab on 10/02/2021.
//

import Foundation
import UIKit

final class HapticsManager {
    
   public static let shared = HapticsManager()
    
    
    private init() {}
    
    //public
    
    
    public func vibrateForSelection() {
        
        DispatchQueue.main.async {
            
            let generator = UISelectionFeedbackGenerator()
            generator.prepare()
            generator.selectionChanged()
            
        }
    }
    
    public func vibrate(type: UINotificationFeedbackGenerator.FeedbackType) {
        
        DispatchQueue.main.async {
            
            let generator = UINotificationFeedbackGenerator()
            generator.prepare()
            generator.notificationOccurred(type)
            
        }
        
    }
   
}

