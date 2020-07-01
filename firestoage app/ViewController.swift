//
//  ViewController.swift
//  firestoage app
//
//  Created by admin on 28/06/2020.
//  Copyright © 2020 Blank. All rights reserved.
//

import UIKit
import Photos
import FirebaseStorage
import Firebase
import FirebaseUI


class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageDownloaded: UIImageView!
    var imagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePickerController.delegate = self
        


    }
    
    @IBAction func pulledImageTapped(_ sender: Any) {
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        let ref = storageRef.child("UploadPhotoOne")
        imageDownloaded.sd_setImage(with: ref)
        print("Pulled an image")
        
       }
    
    
    @IBAction func uploadImageTapped(_ sender: Any) {
        self.imagePickerController.sourceType = .photoLibrary
        self.present(self.imagePickerController, animated: true, completion: nil)
        
    }
    
    func checkPermissions() {
        
        
    }
    
    func requestAuthHandler(status: PHAuthorizationStatus) {
        if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized {
            print("We have acces to photos")
        } else {
            print("We dont have acces to photos")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let url = info[UIImagePickerController.InfoKey.imageURL] as? URL {
            print(url)
            uploadToCloud(fileURL: url)
        }
        imagePickerController.dismiss(animated: true, completion: nil)
    }
    func uploadToCloud(fileURL : URL ) {
        let storage = Storage.storage()
        
        let data = Data()
        
        let storageRef = storage.reference()
        
        let localFule = fileURL
        
        let photoRef = storageRef.child("UploadPhotoOne")
        
        let uploadTask = photoRef.putFile(from: localFule, metadata: nil) { (metadata, err) in
            guard let metadata = metadata else {
                print(err?.localizedDescription)
                return
                }
            print("Photo Upload!!!!")
        }
    }
    
    
    
}
