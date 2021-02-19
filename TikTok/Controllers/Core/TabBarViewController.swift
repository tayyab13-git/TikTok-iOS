//
//  TabBarViewController.swift
//  TikTok
//
//  Created by Tayyab on 11/02/2021.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpControllers()
    }
    
    
    private func setUpControllers() {
        
        let home  = HomeViewController()
        let explore = ExploreViewController()
        let camera = CameraViewController()
        let notification = NotificationViewController()
        let profile = ProfileViewController(user: User(name: "self", profilePictureURL: nil, identifier: "abc123"))
        
        home.title = "Home"
        notification.title = "Notification"
        profile.title = "Profile"
        
        //navigation itmes
        let nav1 = UINavigationController(rootViewController: home)
        let nav2 = UINavigationController(rootViewController: explore)
        let nav3 = UINavigationController(rootViewController: notification)
        let nav4 = UINavigationController(rootViewController: profile)
        
        // for segement we need to clear the navigation bar for this we do
        nav1.view.backgroundColor = .clear
        nav1.navigationBar.backgroundColor = .clear
        nav1.navigationBar.setBackgroundImage(UIImage(), for: .default)
        nav1.navigationBar.shadowImage = UIImage()
        
        //Tab Bar items using sf symbols
        nav1.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "house"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "safari"), tag: 2)
        camera.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "camera"), tag: 3)
        nav3.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "bell"), tag: 4)
        nav4.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "person.circle"), tag: 5)
        
        //setting up
        setViewControllers( [nav1, nav2, camera, nav3, nav4], animated: false)
        
    }
}
