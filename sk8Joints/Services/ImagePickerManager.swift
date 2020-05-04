//
//  ImagePickerManager.swift
//  sk8Joints
//
//  Created by Student Loaner 3 on 11/25/19.
//  Copyright © 2019 Maximo Hinojosa. All rights reserved.
//

import Foundation
import UIKit


class ImagePickerManager: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Properties
    
    let imagePickerController = UIImagePickerController()
    let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
    var pickerImageCallback: ((UIImage?) -> Void)?
    var viewController: UIViewController?
    
    // MARK: - Init
    
    override init() {
        super.init()
    }
    
    // MARK: - Methods & Delegate Methods
    
    // NOTE:
    func pickImage(_ viewController: UIViewController, _ completion: @escaping (UIImage?) -> Void) {
        self.pickerImageCallback = completion
        self.viewController = viewController
        showChooseSourceTypeAlertController()
    }
    
    private func showChooseSourceTypeAlertController() {
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
            self.showImagePickerController(sourceType: .camera)
        }
        let photoLibraryAction = UIAlertAction(title: "Gallery", style: .default) { (action) in
            self.showImagePickerController(sourceType: .photoLibrary)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        imagePickerController.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(photoLibraryAction)
        alert.addAction(cancelAction)
        self.viewController!.present(alert, animated: true, completion: nil)
    }
    
    private func showImagePickerController(sourceType: UIImagePickerController.SourceType) {
        alert.dismiss(animated: true, completion: nil)
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = sourceType
        imagePickerController.modalPresentationStyle = .fullScreen
        self.viewController!.present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editeImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            pickerImageCallback?(editeImage.scaled(with: 0.297)!)
        } else {
            pickerImageCallback?(nil)
        }
        imagePickerController.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePickerController.dismiss(animated: true, completion: nil)
    }
}
