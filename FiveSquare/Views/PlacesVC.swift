//
//  PlacesVC.swift
//  FiveSquare
//
//  Created by Yasin Cengiz on 26.02.2020.
//  Copyright © 2020 MrYC. All rights reserved.
//

import UIKit
import Parse

class PlacesVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var registerVC = RegisterVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add
            , target: self, action: #selector(addButtonClicked))
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logOutButtonClicked))
        
    }
    

   
    @objc func addButtonClicked() {
        
    }
    
    @objc func logOutButtonClicked() {
        PFUser.logOutInBackground { (error) in
            if error != nil {
                self.registerVC.pushAlert(title: "Error", message: error?.localizedDescription ?? "Error")
            } else {
                self.performSegue(withIdentifier: "toSignUpVC", sender: nil)
            }
        }
    }
    
    
        

}
