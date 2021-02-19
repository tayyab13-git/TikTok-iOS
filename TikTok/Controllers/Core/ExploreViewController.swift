//
//  ExploreViewController.swift
//  TikTok
//
//  Created by Tayyab on 10/02/2021.
//

import UIKit

class ExploreViewController: UIViewController {

   //MARK: - Properties
    
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
        setupSearchBar()
        setupCollectionView()
    
    
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
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView = collectionView
        
        
    }
    
    private func layout(for section: Int) -> NSCollectionLayoutSection {
        
    }
}


//MARK: - Extensions

extension ExploreViewController: UISearchBarDelegate {
    
    
    
}

extension ExploreViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
    
    
    
}
