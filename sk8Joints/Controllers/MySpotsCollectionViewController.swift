//
//  MySpotsViewController.swift
//  SkateJoints
//
//  Created by Student Loaner 3 on 10/16/19.
//  Copyright © 2019 Maximo Hinojosa. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseStorage
import Kingfisher
import GoogleSignIn



final class MySpotsCollectionViewController: UICollectionViewController, UpdateSpotsDelegate {
    private var viewModel: MySpotViewModel! {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    init(viewModel: MySpotViewModel) {
        self.viewModel = viewModel
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        updateCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    // NOTE: updates the collection view with data
    private func updateCollectionView() {
        viewModel.populateSpots(completionHandler: {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        })
    }
    
    private func setupViews() {
        self.collectionView.register(MySpotCollectionViewCell.self, forCellWithReuseIdentifier: MySpotCollectionViewCell.description())
        collectionView.backgroundColor = .white
        setUpNavigationUI()
    }
    
    func shouldUpdateSpots(isEnableUpdate: Bool) {
        if isEnableUpdate {
            viewModel.populateSpots(completionHandler: {
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            })
        }
    }
    
    @objc func didPressedNavigateBtn(_ sender: UIButton) {
        let spotMapVC = SpotMapViewController()
        spotMapVC.mySpots = viewModel.spotArr
        spotMapVC.modalPresentationStyle = .fullScreen
        navigationController?.present(spotMapVC, animated: true, completion: nil)
    }
    
    @objc private func didPressAddSpot() {
        let addMySpotVC = AddSpotViewController(viewModel: AddMySpotViewModel.sharedModel)
        addMySpotVC.delegate = self
        let nav = UINavigationController(rootViewController: addMySpotVC)
        navigationController?.present(nav, animated: true, completion: nil)
    }
    
    @objc func didPressedSignOut() {
        print("pressed sign out button")
        GIDSignIn.sharedInstance()?.signOut()
        dismiss(animated: true, completion: nil)
    }
    
    // TODO: View model should take care of this
    private func setUpNavigationUI() {
        navigationController?.navigationBar.topItem?.title = "My Spots"
        let button =  UIButton(type: .custom)
        let addImage = UIImage(named: "add")?.scaled(with: 0.3)
        button.setImage(addImage, for: .normal)
        button.addTarget(self, action: #selector(didPressAddSpot), for: .touchUpInside)
        button.frame = CGRect(x:0, y:0, width: 10, height: 10)
        let barButton = UIBarButtonItem(customView: button)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(didPressedSignOut))
        navigationItem.rightBarButtonItem = barButton
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1568627451, green: 0.4, blue: 0.5254901961, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 22)!]
    }
}


// MARK: - Delegate Flowlayout Methods
extension MySpotsCollectionViewController: UICollectionViewDelegateFlowLayout {
    // NOTE: spacing for sections
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    // NOTE: size for cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/2 + 165, height: view.frame.height / 2 - 235)
    }
    
    
    // NOTE: insets for sections
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 25, left: 0, bottom: 25, right: 0)
    }
    
}

// MARK: - DataSource & Delegate Methods
extension MySpotsCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.spotArr.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MySpotCollectionViewCell.description(), for: indexPath) as! MySpotCollectionViewCell
        let spot = viewModel.spotArr[indexPath.row]
        cell.configureCell(spot: spot)
        cell.navigationLogo.tag = indexPath.row
        cell.navigationLogo.addTarget(self, action: #selector(didPressedNavigateBtn), for: .touchUpInside)
        return cell
    }
}
