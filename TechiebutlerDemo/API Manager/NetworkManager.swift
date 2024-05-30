//
//  NetworkManager.swift
//  TechiebutlerDemo
//
//  Created by Kshitija on 29/05/24.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    func fetchPosts(page: Int, limit: Int, completion: @escaping (Result<[UserModel], Error>) -> Void) {
        let urlString = "https://jsonplaceholder.typicode.com/posts?_page=\(page)&_limit=\(limit)"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: nil)))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: nil)))
                return
            }
            do {
                let posts = try JSONDecoder().decode([UserModel].self, from: data)
                completion(.success(posts))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}


