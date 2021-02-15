//
//  ViewController.swift
//  TikTok
//
//  Created by Tayyab on 09/02/2021.
//

import UIKit

class HomeViewController: UIViewController {


    //MARK: - vars
    
     let horizontalScrollView: UIScrollView = {
        
       let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.isPagingEnabled = true
        return scrollView
    }()
    
    let control: UISegmentedControl = {
        let titles = ["Following", "For You"]
        let control = UISegmentedControl(items: titles)
        control.selectedSegmentIndex = 1
        control.backgroundColor = nil
        control.selectedSegmentTintColor = .white
        return control
        
    }()
    
    private var  forYouPosts = PostModel.mockModel()
    private var  follwingPosts = PostModel.mockModel()

    
    
    //MARK: - viewLifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(horizontalScrollView)
        horizontalScrollView.delegate = self
        setupFeed()
        horizontalScrollView.contentOffset = CGPoint(x: view.width, y: 0)
        setupHeaderButtons()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
            
        horizontalScrollView.frame = view.bounds
    }
    
    
//MARK: - Functions

    private func setupFeed() {
        
        horizontalScrollView.contentSize = CGSize(width: view.width * 2, height: view.height)
        setupFollowingFeed()
         setupForYouFeed()
        
    }
    
    private func setupHeaderButtons() {
        
        control.addTarget(self, action: #selector(didChangeSegmentControl(_:)), for: .valueChanged)
        navigationItem.titleView = control
        
    }
    
    @objc private func didChangeSegmentControl(_ sender: UISegmentedControl){
        
        horizontalScrollView.contentOffset = CGPoint(x: view.width *  CGFloat(sender.selectedSegmentIndex), y: 0)
        
    }
    
    private func setupFollowingFeed() {
        
        let pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .vertical, options: [:])
        guard let model = follwingPosts.first else {return}
        pageController.setViewControllers([PostViewController(model: model)], direction: .forward, animated: false, completion: nil)
       
        horizontalScrollView.addSubview(pageController.view)
        pageController.view.frame = CGRect(x: 0, y: 0, width: horizontalScrollView.width, height: horizontalScrollView.height)
        pageController.dataSource = self
        addChild(pageController)
        pageController.didMove(toParent: self)
        
    }
    private func setupForYouFeed() {
        
        let pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .vertical, options: [:])
        guard let model = forYouPosts.first else {return}
        pageController.setViewControllers([PostViewController(model: model)], direction: .forward, animated: false, completion: nil)
       
        horizontalScrollView.addSubview(pageController.view)
        pageController.view.frame = CGRect(x: view.width, y: 0, width: horizontalScrollView.width, height: horizontalScrollView.height)
        pageController.dataSource = self
        addChild(pageController)
        pageController.didMove(toParent: self)
        
    }

}

//MARK: - Extentions

extension HomeViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let fromPost = (viewController as? PostViewController)?.model else  {return nil}
        
        guard let index = currentPost.firstIndex(where: {
            
            $0.identifier == fromPost.identifier
        })
        else {return nil}
        
        if index == 0 {
            return nil
        }
        
        let priorIndex = index - 1
        let model = currentPost[priorIndex]
        let vc = PostViewController(model: model)
        return vc
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let fromPost = (viewController as? PostViewController)?.model else  {return nil}
        
        guard let index = currentPost.firstIndex(where: {
            
            $0.identifier == fromPost.identifier
        })
        else {return nil}
        
        guard index < currentPost.count - 1 else {return  nil}
        
        let nextIndex = index + 1
        let model = currentPost[nextIndex]
        let vc = PostViewController(model: model)
        return vc
    }
    //computed Property for checking current view controller
    var currentPost: [PostModel] {
        
        if horizontalScrollView.contentOffset.x == 0 {
            
            // Following
        return follwingPosts
            
        }
        
        //For You Posts
        return forYouPosts
        
    }
}
extension HomeViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.x == 0 || scrollView.contentOffset.x <= (view.width / 2) {
            
            control.selectedSegmentIndex = 0
            
        }
        else if scrollView.contentOffset.x > (view.width / 2)
        {
            
            control.selectedSegmentIndex = 1
        }
    }
}
