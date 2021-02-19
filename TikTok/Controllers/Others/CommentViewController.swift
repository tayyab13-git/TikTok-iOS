//
//  CommentViewController.swift
//  TikTok
//
//  Created by Tayyab on 16/02/2021.
//

import UIKit

protocol CommentViewControllerDelegate: AnyObject {
    
    func didTapCommentCloseButton(_ vc: CommentViewController)
}

class CommentViewController: UIViewController {

   //MARK: - Properties
    
    private let post: PostModel
    weak var delegete: CommentViewControllerDelegate?
    private var comments = [PostComment]()
    
    let closeButton: UIButton = {
      let button = UIButton()
        button.tintColor = .black
        button.setBackgroundImage(UIImage(systemName: "xmark"), for: .normal)
        return button
    }()
    
    let commentTableView: UITableView = {
       
        let tableView = UITableView()
        tableView.register(CommentTableViewCell.self, forCellReuseIdentifier: "CommentTableViewCell")
        return tableView
    }()
    
    
    //MARK: - init
    
    init(post: PostModel) {
        self.post = post
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    
    
    
    
    //MARK: - viewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        view.addSubview(closeButton)
        view.addSubview(commentTableView)
        commentTableView.delegate = self
        commentTableView.dataSource = self
        closeButton.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
        fetchPostComment()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        closeButton.frame = CGRect(x: view.width - 45, y: 10 , width: 35, height: 35)
        commentTableView.frame = CGRect(x: 0, y: closeButton.bottom, width: view.width, height: view.width - closeButton.bottom)
    }
    
    //MARK: - functions
    
    private func fetchPostComment() {
        
        self.comments = PostComment.mockComment()
    }
    
    @objc private func didTapClose() {
        
        delegete?.didTapCommentCloseButton(self)
    }
    
}
extension CommentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let comment = comments[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell", for: indexPath) as? CommentTableViewCell else
        { return UITableViewCell()}
        
        cell.configure(with: comment)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
