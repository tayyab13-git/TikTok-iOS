//
//  ExplorePostsTableViewCell.swift
//  TikTok
//
//  Created by Tayyab on 25/02/2021.
//

import UIKit

class ExplorePostsCollectionViewCell: UICollectionViewCell {

    //MARK: - Properties
    
    static let identifier = "ExplorePostsCollectionViewCell"
    
    let thumbnail: UIImageView = {
        
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    let captionLabel: UILabel = {
        
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .systemFont(ofSize: 10)
        return label
    }()
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 8
        contentView.addSubview(thumbnail)
        contentView.addSubview(captionLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let captionHeight = contentView.height / 5
        thumbnail.frame = CGRect(x: 0, y: 0, width: contentView.width, height: contentView.height - captionHeight)
        captionLabel.frame = CGRect(x: 0, y: contentView.height - captionHeight, width: contentView.width, height: captionHeight)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnail.image = nil
        captionLabel.text = nil
    }
    
    //MARK: - functions
    func configureCell(with model: ExplorePostViewModel){
        thumbnail.image = model.thumbnail
        captionLabel.text = model.title
    }
}
