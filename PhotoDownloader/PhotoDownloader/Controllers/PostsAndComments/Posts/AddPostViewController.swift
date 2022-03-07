//
//  AddPostViewController.swift
//  PhotoDownloader
//
//  Created by Dmitry on 5.03.22.
//

import UIKit

class AddPostViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    var currentUserId: Int?
    var updatePosts: (() -> ())?
   
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    @IBAction func addPostAction(_ sender: Any) {
        addPost()
        
        guard let updatePosts = updatePosts else { return }
        updatePosts()
    }
    
    private func addPost() {
        
        if let userId = currentUserId,
           let title = titleTextField.text,
           let body = bodyTextView.text,
           let url = ApiConstants.postsPathURL {
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let post: [String: Any] = ["userId" : userId,
                                       "title" : title,
                                       "body" : body]
            guard let httpBody = try? JSONSerialization.data(withJSONObject: post, options: []) else { return }
            request.httpBody = httpBody
            
            URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                print(response ?? "")
                
                if let data = data {
                    DispatchQueue.main.async {
                        self?.navigationController?.popViewController(animated: true)
                    }
                } else if let error = error {
                    print(error)
                }
            }.resume()
        }
        
    }
}
