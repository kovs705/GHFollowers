//
//  SearchVC.swift
//  GHFollowers
//
//  Created by Kovs on 04.01.2023.
//

import Foundation
import UIKit

class SearchVC: UIViewController {
    
    let logoImageView = UIImageView()
    let usernameTextfield = GFTextField()
    let loginButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
    
    var isUsernameEntered: Bool {
        return !usernameTextfield.text!.isEmpty // return false if empty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubviews(logoImageView, usernameTextfield, loginButton)
        configureLogoImageView()
        configureTextfield()
        configureButton()
        
        dismissKeyboard()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        usernameTextfield.text = ""
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func configureLogoImageView() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = Images.ghLogo
        
        let topConstraintConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 20 : 80
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstraintConstant),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureTextfield() {
        NSLayoutConstraint.activate([
            usernameTextfield.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            usernameTextfield.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTextfield.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            usernameTextfield.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureButton() {        
        loginButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    
    // MARK: - Keyboard
    func dismissKeyboard() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    
    // MARK: - Data
    @objc func pushFollowerListVC() {
        guard isUsernameEntered else {
           presentGFAlertOnMainThread(title: "Empty username", message: "Please enter a username. We beed to know who to look for ????.", buttonTitle: "Ok")
            return
        }
        
        usernameTextfield.resignFirstResponder()
        
        let followerListVC = FollowerListVC(username: usernameTextfield.text!)
        navigationController?.pushViewController(followerListVC, animated: true)
    }
    
}



extension SearchVC: UITextFieldDelegate {
    // listen to username textfield
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("Did tapped return")
        return true
    }
}
