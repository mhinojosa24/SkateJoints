//
//  File.swift
//  sk8Joints
//
//  Created by Student Loaner 3 on 3/26/20.
//  Copyright © 2020 Maximo Hinojosa. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import GoogleSignIn


class SignInViewController: UIViewController, GIDSignInDelegate{
    
    lazy var googleLoginButton = Button()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        authenticateUser()
        setUpGoogleButton()
        layoutButtonView()
    }
    
    @objc private func googleSignInTapped(_ sender: UIButton) {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    
    
    private func authenticateUser() {
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().presentingViewController = self
        GIDSignIn.sharedInstance().delegate = self
        guard let signIn = GIDSignIn.sharedInstance() else { return }
        if signIn.hasPreviousSignIn() {
            signIn.restorePreviousSignIn()
        }
    }
    
    private func setUpGoogleButton() {
        googleLoginButton = Button(title: "Log in with Google",
                                   titleColor: .gray,
                                   cornerRadius: 10,
                                   backgroundColor: .white,
                                   target: self,
                                   action: #selector(googleSignInTapped),
                                   event: .touchUpInside)
        
        let buttonWidth = googleLoginButton.frame.width
        let imageWidth = googleLoginButton.imageView!.frame.width
        let spacing: CGFloat = 8.0 / 2
        googleLoginButton.setImage(UIImage(named: "google")?.scaled(with: 0.5), for: .normal)
        googleLoginButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: (-buttonWidth + imageWidth - spacing), bottom: 0, right: (imageWidth + spacing))
        googleLoginButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: (imageWidth + spacing), bottom: 0, right: (-imageWidth - spacing))
        googleLoginButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 19)
        
    }
    
    private func layoutButtonView() {
        view.add(subview: googleLoginButton) { (v, p) in [
            v.widthAnchor.constraint(equalTo: p.safeAreaLayoutGuide.widthAnchor, multiplier: 0.6),
            v.heightAnchor.constraint(equalTo: p.safeAreaLayoutGuide.heightAnchor, multiplier: 0.1),
            v.centerXAnchor.constraint(equalTo: p.safeAreaLayoutGuide.centerXAnchor),
            v.centerYAnchor.constraint(equalTo: p.safeAreaLayoutGuide.centerYAnchor, constant: -10)
        ]}
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if (error != nil) {
            print("something went wrong: \(error.localizedDescription)")
            return
        }
        
        print("signed in successfully! \(user.profile.name.description)")
        let mySpotVC = MySpotsCollectionViewController(viewModel: MySpotViewModel())
        let navVC = UINavigationController(rootViewController: mySpotVC)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        if (error != nil) {
            print("something went wrong in signing out \(error.localizedDescription)")
            return
        }
        print("Signed out user \(user.profile.name.description)")
    }
}
