//
//  DisplayStudentViewController.swift
//  SwiftyCompanion
//
//  Created by jdavin on 24/01/2019.
//  Copyright © 2019 Jonathan DAVIN. All rights reserved.
//

import UIKit

class DisplayStudentViewController: UIViewController {

    let studentPicture: UIImage
    let student: Student
    let rootVC: SearchStudentController
    
    let             studImageView: UIImageView = {
        let          iv = UIImageView()
        
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.masksToBounds = true
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 60
        iv.layer.borderColor = UIColor(red: 12 / 255, green: 205 / 255, blue: 213 / 255, alpha: 1).cgColor
        iv.layer.borderWidth = 2
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let downButton: UIButton = {
        let button = UIButton(type: .system)
        let icon = UIImage(named: "downArrow_icon")
        let tintedIcon = icon!.withRenderingMode(.alwaysTemplate)
        button.setImage(tintedIcon, for: .normal)
        button.tintColor = UIColor(white: 1, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        return button
    }()
    
    init(frame: CGRect, student: Student, studentPicture: UIImage, rootVC: SearchStudentController) {
        self.student = student
        self.studentPicture = studentPicture
        self.rootVC = rootVC
        super.init(nibName: nil, bundle: nil)
        
        view.frame = frame
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func   viewDidLoad() {
        super.viewDidLoad()

        setupView()
        
    }
    
    @objc func      backToSearch() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.view.transform =  CGAffineTransform(translationX: 0, y: self.view.frame.height)
        }) { (true) in
            self.rootVC.animateEverythingBackUp()
        }
    }
    
    func            setupView() {
        studImageView.image = studentPicture
        
        view.addSubview(studImageView)
        view.addSubview(downButton)
        
        downButton.addTarget(self, action: #selector(backToSearch), for: .touchUpInside)
        NSLayoutConstraint.activate([
            studImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            studImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 27),
            studImageView.widthAnchor.constraint(equalToConstant: 120),
            studImageView.heightAnchor.constraint(equalToConstant: 120),
            
            downButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            downButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downButton.widthAnchor.constraint(equalToConstant: 44),
            downButton.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
}
