//
//  GFFollowerItemVC.swift
//  GHFollowers
//
//  Created by Kovs on 21.01.2023.
//

import UIKit

protocol GFFollowerItemVCDelegate: AnyObject {
    func didTapGetFollowers(for user: User)
}

class GFFollowerItemVC: GFIteminfoVC {
    
    weak var delegate: GFFollowerItemVCDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureItems()
        
    }
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
        
        actionButton.set(backgroundColor: .systemGreen, title: "GitHub Followers")
    }
    
    override func actionButtonTapped() {
        delegate.didTapGetFollowers(for: user)
    }
    
    
}
