//
//  UserDetailVC.swift
//  TechiebutlerDemo
//
//  Created by Kshitija on 30/05/24.
//

import UIKit

class UserDetailVC: UIViewController {
    
    @IBOutlet weak var idLbl: UILabel!
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var bodyLbl: UILabel!
    
    var post: UserModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "User Details"
        
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
        
            if let post = post {
                idLbl.text = "ID: \(post.id)"
                titleLbl.text = "Title: \(post.title)"
                bodyLbl.text = "Body: \(post.body)"
            }
    }
    
    @objc func backButtonTapped() {
        // Pop the current view controller off the navigation stack
        navigationController?.popViewController(animated: true)
    }

}
