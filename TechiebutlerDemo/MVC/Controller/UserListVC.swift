//
//  UserListVC.swift
//  TechiebutlerDemo
//
//  Created by Kshitija on 29/05/24.
//

import UIKit

class UserListVC: UITableViewController {

    var posts: [UserModel] = []
    var currentPage = 1
    var limit = 10
    var index = 0
    var isFetching = false
    var hasMoreData = true
  
    let loader = UIActivityIndicatorView(style: .medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPosts(page: currentPage)
  
    }
    
    func fetchPosts(page: Int) {
            guard !isFetching else { return }
            isFetching = true
            loader.startAnimating()
            NetworkManager.shared.fetchPosts(page: page, limit: limit) { [weak self] result in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.loader.stopAnimating()
                    self.isFetching = false
                    switch result {
                    case .success(let newPosts):
                        print("limit", self.limit)
                        if newPosts.count < self.limit {
                            self.hasMoreData = false
                        }
                        
                        self.posts.append(contentsOf: newPosts)
                        self.tableView.reloadData()
                        
                    case .failure(let error):
                        print("Failed to fetch posts:", error)
                        self.hasMoreData = false
                    }
                }
            }
        }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts.count + (isFetching ? 1 : 0)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < posts.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
            let post = posts[indexPath.row]
            cell.configure(with: post)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath)
            cell.contentView.addSubview(loader)
            loader.frame = cell.contentView.bounds
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == posts.count - 1 && !isFetching {
            currentPage += 1
            fetchPosts(page: currentPage)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let destination = segue.destination as? UserDetailVC,
                let indexPath = tableView.indexPathForSelectedRow {
                let selectedPost = posts[indexPath.row]
                destination.post = selectedPost
            }
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


