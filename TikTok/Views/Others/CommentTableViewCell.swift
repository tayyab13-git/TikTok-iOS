//
//  CommentTableViewCell.swift
//  TikTok
//
//  Created by Tayyab on 17/02/2021.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    //MARK: - Properties
    
    static let identifier = "CommentTableViewCell"
    
   private let avatarImageView: UIImageView = {
       
        var image = UIImageView()
        
        image.clipsToBounds = true
        image.layer.masksToBounds = true
        return image
    }()
    
   private let commentLabel: UILabel = {
        
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .label
        return label
        
    }()
    
   private let dateLabel: UILabel = {
        
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .secondaryLabel
        return label
        
    }()
    
    
    
    //MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        clipsToBounds = true
        contentView.addSubview(avatarImageView)
        contentView.addSubview(commentLabel)
        contentView.addSubview(dateLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        commentLabel.sizeToFit()
        dateLabel.sizeToFit()
        
        // Assign frames
        let imageSize: CGFloat = 44
        avatarImageView.frame = CGRect(x: 10, y: (contentView.height - imageSize) / 2, width: imageSize, height: imageSize)
       
        let commentlabelHeight  = min(contentView.height - dateLabel.top, commentLabel.height)
        commentLabel.frame = CGRect(x: avatarImageView.right + 10, y: 20 , width: contentView.width - avatarImageView.right - 10, height: commentlabelHeight)
        
        dateLabel.frame = CGRect(x: avatarImageView.right + 10, y: commentLabel.bottom, width: dateLabel.width, height: dateLabel.height)

    }
        
        
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        avatarImageView.image = nil
        commentLabel.text = nil
        dateLabel.text = nil
    }
    
    //MARK: - functions
    
    func configure(with model: PostComment) {
        
        commentLabel.text = model.text
        dateLabel.text = .date(with: model.date)
        if let url = model.user.profilePictureURL {
            print(url)
        }
        else { avatarImageView.image = UIImage(systemName: "person.circle")}
        
    }
    
    
}
