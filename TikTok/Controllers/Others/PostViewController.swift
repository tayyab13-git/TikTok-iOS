//
//  PostViewController.swift
//  TikTok
//
//  Created by Tayyab on 10/02/2021.
//

import UIKit
import AVFoundation


protocol PostViewControllerDelegate: AnyObject {
    
    func postViewController(_ vc: PostViewController, didTapCommentButtonFor post: PostModel)
    func postViewController(_ vc: PostViewController, didTapProfileButtonFor post: PostModel)

}

class PostViewController: UIViewController {

    //MARK: - Properties
    
    var model: PostModel
    weak var delegate: PostViewControllerDelegate?
    var player: AVPlayer?
    var didPlayerTimeEnd: NSObjectProtocol?

    
    //UI Buttons
    private let likeButton: UIButton = {
        
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
        button.tintColor = .white
        button.imageView?.contentMode = .scaleAspectFit
        return button
        
    }()
    
    private let commentButton: UIButton = {
        
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "text.bubble"), for: .normal)
        button.tintColor = .white
        button.imageView?.contentMode = .scaleAspectFit
        return button
        
    }()
    
    private let shareButton: UIButton = {
        
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.tintColor = .white
        button.imageView?.contentMode = .scaleAspectFit
        return button
        
    }()
    
    private let profileButton: UIButton = {
        
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "test"), for: .normal)
        button.tintColor = .white
        button.imageView?.contentMode = .scaleAspectFill
        button.layer.masksToBounds = true
        return button
        
    }()
    
    let captionLabel: UILabel = {
       
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)
        label.text = "Check out this video #fyp #forYou #foryouPage"
        label.textAlignment = .left
        return label
    }()
    
    
    
    //MARK: - init

    init(model: PostModel) {
       
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    

    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureVideo()
        let colors: [UIColor] = [.brown, .blue, .green, .purple, .systemRed, .systemPink]
        
        view.backgroundColor = colors.randomElement()
        setUpButtons()
        setupDoubleTapToLike()
        view.addSubview(captionLabel)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let size: CGFloat = 40
        let tabBarHeight = (tabBarController?.tabBar.height ?? 0)
        let yStart: CGFloat = view.height - (size * 4) - 30 - view.safeAreaInsets.bottom - tabBarHeight
        for (index, button)  in [likeButton, commentButton, shareButton].enumerated()
        {
            button.frame = CGRect(x: view.width - size - 5, y: yStart + (CGFloat(index) * 10) + (CGFloat(index) * size), width: size, height: size)
        }
        
        captionLabel.sizeToFit()
        let labelSize = captionLabel.sizeThatFits(CGSize(width: view.width - size - 12, height: view.height))
        captionLabel.frame = CGRect(x: 5,
                                    y: view.height - 10 - view.safeAreaInsets.bottom - labelSize.height - (tabBarController?.tabBar.height ?? 0),
                                    width: labelSize.width,
                                    height: labelSize.height)
        
        profileButton.frame = CGRect(x: likeButton.left,
                                     y: likeButton.top - 10 - size,
                                     width: size,
                                     height: size)
        
        profileButton.layer.cornerRadius = size / 2
    }
    
    
    
    //MARK: - Functions

    private func setUpButtons()  {
        
        view.addSubview(likeButton)
        view.addSubview(commentButton)
        view.addSubview(shareButton)
        view.addSubview(profileButton)
        
        likeButton.addTarget(self, action: #selector(didTapLike), for: .touchUpInside)
        commentButton.addTarget(self, action: #selector(didTapComment), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(didTapShare), for: .touchUpInside)
        profileButton.addTarget(self, action: #selector(didTapProfile), for: .touchUpInside)
        
    }
    
    
    func setupDoubleTapToLike() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapDouble(_:)))
        tap.numberOfTapsRequired = 2
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
    }
    
    func configureVideo() {
        
        guard let path = Bundle.main.path(forResource: "video", ofType: "mp4") else {
            
            return
        }
        let url = URL(fileURLWithPath: path)
        let player = AVPlayer(url: url)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = view.bounds
        playerLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(playerLayer)
        player.volume = 0
        player.play()
        
        
        didPlayerTimeEnd = NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main, using: { _ in
            
            player.seek(to: .zero)
            player.play()
            
            
        })
    }
    
    
    //MARK: - targets functions
   
    @objc private func didTapDouble(_ gesture: UITapGestureRecognizer) {
        
        if !model.isLikedByCurrentUser {
            model.isLikedByCurrentUser = true
        }
        
        let touchPoint = gesture.location(in: view)
        
        let imageView = UIImageView(image: UIImage(systemName: "heart.fill"))
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        imageView.center = touchPoint
        view.addSubview(imageView)
        imageView.alpha = 0
        
        UIView.animate(withDuration: 0.2) {
            imageView.alpha = 1
        } completion: { (done) in
            if done {
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    
                    UIView.animate(withDuration: 0.2) {
                        imageView.alpha = 0
                    } completion: { (done) in
                        if done
                        {
                            imageView.removeFromSuperview()
                        }
                    }
                }
          }
       }
    }
    
    @objc private func didTapProfile() {
        delegate?.postViewController(self, didTapProfileButtonFor: model)
    }
    
    @objc private func didTapLike() {
    
        model.isLikedByCurrentUser = !model.isLikedByCurrentUser
        likeButton.tintColor = model.isLikedByCurrentUser ? .systemRed : .white
    }
    
    
    @objc private func didTapComment() {
        
        delegate?.postViewController(self, didTapCommentButtonFor: model)
        
    }
    
    @objc private func didTapShare() {
        
        guard let url = URL(string: "https://www.tiktok.com/user/23") else {return}
        
        let vc = UIActivityViewController(activityItems: [url], applicationActivities: [])
        present(vc, animated: true)
    }
}
