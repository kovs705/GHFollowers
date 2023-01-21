//
//  GFRepoItemVC.swift
//  GHFollowers
//
//  Created by Kovs on 21.01.2023.
//

import Foundation

class GFRepoItemVC: GFItemItemVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureItems()
        
    }
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        
        actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
    }
    
    
    
}
