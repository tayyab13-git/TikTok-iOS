//
//  PostViewController.swift
//  TikTok
//
//  Created by Tayyab on 10/02/2021.
//

import UIKit

class PostViewController: UIViewController {

    let model: PostModel
    
    init(model: PostModel) {
       
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let colors: [UIColor] = [.brown, .blue, .green, .purple, .systemRed, .systemPink]
        
        view.backgroundColor = colors.randomElement()
        
    }
    
    
    
}
