//
//  ProfileViewController.swift
//  TikTok
//
//  Created by Tayyab on 10/02/2021.
//

import UIKit

class ProfileViewController: UIViewController {

    //MARK: - Properties
    var user: User
    
    
    
    //MARK: - init
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    
    //MARK: - view LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        title = user.name.uppercased()
    }
}

//MARK: - functions
