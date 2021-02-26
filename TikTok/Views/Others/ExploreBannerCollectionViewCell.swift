//
//  ExploreBannerTableViewCell.swift
//  TikTok
//  Created by Tayyab on 25/02/2021.
//

import UIKit

class ExploreBannerCollectionViewCell: UICollectionViewCell {

    
    //MARK: - Properties
    
    static let identifier = "ExploreBannerCollectionViewCell"
    
    let imageView: UIImageView = {
    
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        return imageView
        
    }()
    
    let label: UILabel = {
       
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 8
        contentView.addSubview(imageView)
        contentView.addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.sizeToFit()
        imageView.frame = contentView.bounds
        label.frame  = CGRect(x: 10, y: contentView.height - 5 - label.height, width: label.width, height: label.height)
        contentView.bringSubviewToFront(label)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        label.text = nil
    }
    
    //MARK: - functions
    
    func configureCell(with model: ExploreBannerViewModel) {
     
        imageView.image = model.image
        label.text = model.title
        
    }
}
