//
//  ViewController.swift
//  cloudinary
//
//  Created by Arun Netram on 01/09/17.
//  Copyright © 2017 demo. All rights reserved.
//

import UIKit
import MobileCoreServices
import QuartzCore
import Cloudinary

final class ViewController: UIViewController {
    
    let imagePicker = UIImagePickerController()
    @IBOutlet weak var addBtn: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        addBtn.addTarget(self, action: #selector(addPhotosToCloudinary), for: .touchUpInside)
        addBarBtn()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    fileprivate func configureCloudinary() {
        let config = CLDConfiguration(cloudName: "dhocnik9q", apiKey: "852131979334893")
        let cloudinary = CLDCloudinary(configuration: config)
//        cloudinary.createUploader().upload(data: <#T##Data#>, uploadPreset: <#T##String#>)
    }
    
    func addBarBtn() {
        let barBtn = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(changeImageResolution))
        self.navigationItem.rightBarButtonItem = barBtn
    }
    
    func changeImageResolution() {
        let alert = UIAlertController(title: nil, message: "Select from available sizes", preferredStyle: .actionSheet)
        let smallImageAction = UIAlertAction(title: "200x200", style: .default) { (action) in
            
        }
        let largeImageAction = UIAlertAction(title: "300x300", style: .default) { (action) in
            
        }
        alert.addAction(smallImageAction)
        alert.addAction(largeImageAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func addPhotosToCloudinary() {
        let alert = UIAlertController(title: "ADD", message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "From Camera", style: .default) { (action) in
            self.openCamera()
        }
        let libraryAction = UIAlertAction(title: "From Library", style: .default) { (action) in
            self.openPhotoLibrary()
        }
        alert.addAction(cameraAction)
        alert.addAction(libraryAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            print("This device doesn't have a camera.")
            return
        }
        
        imagePicker.sourceType = .camera
        imagePicker.cameraDevice = .rear
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for:.camera)!
        imagePicker.delegate = self
        
        present(imagePicker, animated: true)
    }

    
    func openPhotoLibrary() {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            print("can't open photo library")
            return
        }
        
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        
        present(imagePicker, animated: true)
    }
    
    func uploadPhoto(image: UIImage) {
        let cloudinary = CLDCloudinary(configuration: CLDConfiguration(cloudName: AppDelegate.cloudName, secure: true))
        let imageData = UIImagePNGRepresentation(image)
        cloudinary.createUploader().upload(data: imageData!, uploadPreset: AppDelegate.uploadPreset)
    }
    
}


extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        defer {
            picker.dismiss(animated: true)
        }
        
        print(info)
        // get the image
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            return
        }
        
        // call uploader service from view controller here
//        uploadPhoto(image: image)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        defer {
            picker.dismiss(animated: true)
        }
        
        print("did cancel")
    }
}

//extension ViewController: CLUploaderDelegate {
//    
//}
