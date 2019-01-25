//
//  LoadingAppController.swift
//  SwiftyCompanion
//
//  Created by jdavin on 25/01/2019.
//  Copyright © 2019 Jonathan DAVIN. All rights reserved.
//

import UIKit

class LoadingAppController: UIViewController {

    let                 backgroundImageView: UIImageView = {
        let             iv = UIImageView()
        
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = false
        iv.image = #imageLiteral(resourceName: "42_background")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let                 logoImageView: UIImageView = {
        let             iv = UIImageView()
        
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "logo")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(backgroundImageView)
        view.addSubview(logoImageView)

        let bottomConstraint: NSLayoutConstraint = backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        if (view.frame.height < 740) {
            bottomConstraint.constant = 33
        }
        NSLayoutConstraint.activate([
            bottomConstraint,
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: view.frame.width - 100),
            logoImageView.heightAnchor.constraint(equalToConstant: 130)
        ])
    }
}
