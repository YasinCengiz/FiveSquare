//
//  AddPlaceVC.swift
//  FiveSquare
//
//  Created by Yasin Cengiz on 7.03.2020.
//  Copyright © 2020 MrYC. All rights reserved.
//

import UIKit

class AddPlaceVC: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var placeNameText: UITextField!
    @IBOutlet weak var placeTypeText: UITextField!
    @IBOutlet weak var placeAthmosphereText: UITextField!
    @IBOutlet weak var placeImageView: UIImageView!
    
    var placeModel = PlaceModel.sharedInstance
    var registerVC = RegisterVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        placeImageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        placeImageView.addGestureRecognizer(gestureRecognizer)
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        placeImageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        
        if placeNameText.text != "", placeTypeText.text != "", placeAthmosphereText.text != "" {
            if let chosenImage = placeImageView.image {
                placeModel.placeName = placeNameText.text!
                placeModel.placeType = placeTypeText.text!
                placeModel.placeAtmosphere = placeAthmosphereText.text!
                placeModel.placeImage = chosenImage
            }
            performSegue(withIdentifier: "toMapVC", sender: nil)
        } else {
            registerVC.pushAlert(title: "Error!", message: "Fields must not be empty!")
        }
        

        
    }
    
    
    @objc func chooseImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
    }

}
