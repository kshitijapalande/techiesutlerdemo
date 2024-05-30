//
//  UserTableViewCell.swift
//  TechiebutlerDemo
//
//  Created by Kshitija on 29/05/24.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    
    func configure(with post: UserModel) {
            titleLbl.text = "\(post.id). \(post.title)"
            DispatchQueue.global(qos: .userInitiated).async {
                let computedText = self.intensiveComputation(for: post)
                DispatchQueue.main.async {
                    self.titleLbl.text = "\(post.id). \(post.title)"
                }
            }
        }

        private func intensiveComputation(for post: UserModel) -> String {
            let startTime = CFAbsoluteTimeGetCurrent()
            // Simulate intensive processing
            Thread.sleep(forTimeInterval: 1)
            let result = "\(post.body.count) characters"
            let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
            print("Intensive computation took \(timeElapsed) seconds")
            return result
        }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
