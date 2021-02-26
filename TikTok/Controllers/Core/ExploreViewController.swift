//
//  ExploreViewController.swift
//  TikTok
//
//  Created by Tayyab on 10/02/2021.
//

import UIKit

class ExploreViewController: UIViewController {

   //MARK: - Properties
    
    var sections = [ExploreSection]()
    
    let searchBar: UISearchBar = {
      let bar = UISearchBar()
        bar.placeholder = "Search Videos"
        bar.layer.cornerRadius = 8
        bar.layer.masksToBounds = true
        return bar
        
    }()
    var collectionView: UICollectionView?
    
    //MARK: - init
    
    
    
    
    //MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        configureModel()
        setupSearchBar()
        setupCollectionView()
        
    
    
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }
    
    
    //MARK: - functions
    
    private func setupSearchBar() {
        
        navigationItem.titleView = searchBar
        searchBar.delegate = self
        
    }
    
    private func setupCollectionView() {
        
        let layout = UICollectionViewCompositionalLayout { (section, _) -> NSCollectionLayoutSection? in
            
            return self.layout(for: section)
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.addSubview(collectionView)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(ExploreBannerCollectionViewCell.self, forCellWithReuseIdentifier: ExploreBannerCollectionViewCell.identifier)
        collectionView.register(ExplorePostsCollectionViewCell.self, forCellWithReuseIdentifier: ExplorePostsCollectionViewCell.identifier)
        collectionView.register(ExploreHashTagCollectionViewCell.self, forCellWithReuseIdentifier: ExploreHashTagCollectionViewCell.identifier)
        collectionView.register(ExploreUserCollectionViewCell.self, forCellWithReuseIdentifier: ExploreUserCollectionViewCell.identifier)

        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView = collectionView
        
        
    }
    
    private func layout(for section: Int) -> NSCollectionLayoutSection {
        
        let sectionType = sections[section].type
        
        switch sectionType {
        
        case .banner:
            
            //item
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 10)
            // group
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(200)), subitems: [item])
            //section
            let sectionLayout = NSCollectionLayoutSection(group: group)
            sectionLayout.orthogonalScrollingBehavior = .groupPaging
            // return
            return sectionLayout
            
        case .trendingPosts, .recommended, .new:
            
            //item
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 10)
            // group
            let verticalgroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(100), heightDimension: .absolute(300)), subitem: item , count: 2)
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(100), heightDimension: .absolute(300)), subitems: [verticalgroup])
            //section
            let sectionLayout = NSCollectionLayoutSection(group: group)
            sectionLayout.orthogonalScrollingBehavior = .groupPaging
            // return
            return sectionLayout
            
        case .user:
            
            //item
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 10)
            // group
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(200), heightDimension: .absolute(200)), subitems: [item])
            //section
            let sectionLayout = NSCollectionLayoutSection(group: group)
            sectionLayout.orthogonalScrollingBehavior = .groupPaging
            // return
            return sectionLayout
            
        case .trendingHashtags:
            
            //item
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 10)
            // group
            let verticalgroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60)), subitems: [item])
            //section
            let sectionLayout = NSCollectionLayoutSection(group: verticalgroup)
            // return
            return sectionLayout
            
        case .popular:
            
            //item
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 10)
            // group
            let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(110), heightDimension: .absolute(200)), subitems: [item])
            
            //section
            let sectionLayout = NSCollectionLayoutSection(group: group)
            sectionLayout.orthogonalScrollingBehavior = .continuous
            // return
            return sectionLayout
            
        
            
        }
       
    }
    
    func configureModel() {
       
        sections.append(
            
            ExploreSection(type: .banner, cells: ExploreManager.shared.getExploreBanner().compactMap({
                
                return ExploreCells.banner(viewModel: $0)
            }))
        )
        
        //trending posts
        
       
        sections.append(
                
            ExploreSection(type: .trendingPosts, cells: ExploreManager.shared.getExplorePosts().compactMap(
                            {
                                ExploreCells.post(viewModel: $0)
                            }))
        )
        
        //users
       
        sections.append(
            
            ExploreSection(type: .user, cells: ExploreManager.shared.getExploreUser().compactMap({
                
                ExploreCells.user(viewModel: $0)
            }))
        
        )
        
        
        //trending Hashtags
        sections.append(
            
            ExploreSection(type: .trendingHashtags, cells: ExploreManager.shared.getExploreHashTag().compactMap({
                
                ExploreCells.hashtag(viewModel: $0)
            }))
        
        )
        
       
        
        //recommended
        sections.append(
                
            ExploreSection(type: .recommended, cells: ExploreManager.shared.getExplorePosts().compactMap(
                            {
                                ExploreCells.post(viewModel: $0)
                            }))
        )
        //popular
        
        
        
        //new
        sections.append(
                
            ExploreSection(type: .new, cells: ExploreManager.shared.getExplorePosts().compactMap(
                            {
                                ExploreCells.post(viewModel: $0)
                            }))
        )
    }
}


//MARK: - Extensions

extension ExploreViewController: UISearchBarDelegate {
    
}

extension ExploreViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = sections[indexPath.section].cells[indexPath.row]
        
        switch model {
        
        case .banner(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExploreBannerCollectionViewCell.identifier, for: indexPath) as? ExploreBannerCollectionViewCell
            else {
                return collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            }
            cell.configureCell(with: viewModel)
            return cell
        case .post(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExplorePostsCollectionViewCell.identifier, for: indexPath) as? ExplorePostsCollectionViewCell
            else {
                return collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            }
            cell.configureCell(with: viewModel)
            return cell
        case .hashtag(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExploreHashTagCollectionViewCell.identifier, for: indexPath) as? ExploreHashTagCollectionViewCell
            else {
                return collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            }
            cell.configureCell(with: viewModel)
            return cell
        case .user(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExploreUserCollectionViewCell.identifier, for: indexPath) as? ExploreUserCollectionViewCell
            else {
                return collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            }
            cell.configureCell(with: viewModel)
            return cell
        }
        
    }
    
    
    
}
