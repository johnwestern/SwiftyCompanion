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
        iv.backgroundColor = UIColor(white: 0.8, alpha: 0.8)
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
        tf.placeholder = "Student's login..."
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
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
        
        setupView()
    }
    
    func            setupView() {
        background = BackgroundView(frame: view.frame, root: self)
        
        view.addSubview(background!)
        view.addSubview(loginContainer)
        loginContainer.addSubview(loginTF)
        
        loginContainer.alpha = 0
        NSLayoutConstraint.activate([
            loginContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30),
            loginContainer.widthAnchor.constraint(equalToConstant: view.frame.width - 120),
            loginContainer.heightAnchor.constraint(equalToConstant: 40),
            
            loginTF.topAnchor.constraint(equalTo: loginContainer.topAnchor),
            loginTF.bottomAnchor.constraint(equalTo: loginContainer.bottomAnchor),
            loginTF.leadingAnchor.constraint(equalTo: loginContainer.leadingAnchor, constant: 16),
            loginTF.trailingAnchor.constraint(equalTo: loginContainer.trailingAnchor, constant: -16)
        ])
    }
}

extension           SearchStudentController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
