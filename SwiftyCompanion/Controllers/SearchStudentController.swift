//
//  SearchStudentController.swift
//  SwiftyCompanion
//
//  Created by Jonathan DAVIN on 1/23/19.
//  Copyright © 2019 Jonathan DAVIN. All rights reserved.
//

import UIKit

class               SearchStudentController: UIViewController, UITextFieldDelegate {
    var             background: BackgroundView?
    
    let             loginContainer: UIView = {
        let         iv = UIView()
        
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = UIColor(white: 1, alpha: 0.9)
        iv.layer.masksToBounds = true
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 10
        return iv
    }()

    let             loginTF : UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        tf.returnKeyType = .done
        tf.autocorrectionType = .no
        tf.enablesReturnKeyAutomatically = true
        tf.placeholder = "login"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let searchButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.backgroundColor = UIColor(red: 12 / 255, green: 205 / 255, blue: 213 / 255, alpha: 1)
        button.layer.cornerRadius = 10
        button.setAttributedTitle(NSAttributedString(string: "Search", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white,  NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .heavy)]), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.portrait, andRotateTo: UIInterfaceOrientation.portrait)
    }
    
    override func   viewDidLoad() {
        super.viewDidLoad()
        
        print(token)
        setupView()
    }
    
    @objc func      handleSearch() {
        if var login = loginTF.text, login != "", !login.contains(" ") {
            APIManager().getStudent(login.lowercased()) { (student) in
                let imageview = UIImageView()
                imageview.lo
                print(student.email!)
                print(student.cursus![0].level!)
            }
        } else {
            print("user does not exists")
        }
        
    }
    
    func            setupView() {
        
        
        
        view.addSubview(loginContainer)
        loginContainer.addSubview(loginTF)
        view.addSubview(searchButton)
        
        searchButton.addTarget(self, action: #selector(handleSearch), for: .touchUpInside)
        
        loginContainer.alpha = 0
        searchButton.alpha = 0
        
        NSLayoutConstraint.activate([
            loginContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30),
            loginContainer.widthAnchor.constraint(equalToConstant: view.frame.width - 120),
            loginContainer.heightAnchor.constraint(equalToConstant: 44),
            
            loginTF.topAnchor.constraint(equalTo: loginContainer.topAnchor),
            loginTF.bottomAnchor.constraint(equalTo: loginContainer.bottomAnchor),
            loginTF.leadingAnchor.constraint(equalTo: loginContainer.leadingAnchor, constant: 16),
            loginTF.trailingAnchor.constraint(equalTo: loginContainer.trailingAnchor, constant: -16),
            
            searchButton.topAnchor.constraint(equalTo: loginTF.bottomAnchor, constant: view.frame.height * 0.03),
            searchButton.leadingAnchor.constraint(equalTo: loginContainer.leadingAnchor),
            searchButton.trailingAnchor.constraint(equalTo: loginContainer.trailingAnchor),
            searchButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        background = BackgroundView(frame: view.frame, root: self)
        view.addSubview(background!)
        background?.layer.zPosition = -1
        background?.isUserInteractionEnabled = false
    }
}

extension           SearchStudentController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
