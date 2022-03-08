//
//  AddCommentVC.swift
//  PhotoDownloader
//
//  Created by Dmitry on 7.03.22.
//

import UIKit

class AddCommentVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    var currentPostID: Int?
    var updateComments: (() -> ())?

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var bodyTextField: UITextField!
    
    @IBAction func addCommentAction(_ sender: Any) {
        addComment()
    }
    
    private func addComment() {
        if let postId = currentPostID,
           let name = nameTextField.text,
           let email = emailTextField.text,
           let body = bodyTextField.text,
           let url = ApiConstants.commentsPathURL {
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let comment: [String: Any] = ["postId" : postId,
                                          "name" : name,
                                          "email" : email,
                                          "body" : body]
            guard let httpBody = try? JSONSerialization.data(withJSONObject: comment, options: []) else { return }
            request.httpBody = httpBody
            
            URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                print(response ?? "")
                
                if let data = data {
                    DispatchQueue.main.async {
                        guard let updateComments = self?.updateComments else { return }
                        updateComments()
                    }
                } else if let error = error {
                    print(error)
                }
            }.resume()
        }
    }
}
