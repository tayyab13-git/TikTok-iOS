//
//  ExploreHashTagTableViewCell.swift
//  TikTok
//
//  Created by Tayyab on 25/02/2021.
//

import UIKit

class ExploreHashTagCollectionViewCell: UICollectionViewCell {

    //MARK: - properties
    static let identifier =  "ExploreHashTagCollectionViewCell"
    
    let textLabel: UILabel = {
       
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    let countLabel: UILabel = {
        
        let label = UILabel()
        label.textColor = .white
        return label
        
    }()
    
    let iconImageView: UIImageView = {
       
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        contentView.addSubview(textLabel)
        contentView.addSubview(countLabel)
        contentView.addSubview(iconImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

    //MARK: - functions
    func configureCell(with model: ExploreHashTagViewModel){
        
    }

}
