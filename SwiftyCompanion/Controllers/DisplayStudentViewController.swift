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
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let loginLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let phoneLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let levelLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let gradeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let progressBar: UIProgressView = {
        let pro = UIProgressView()
        
        pro.translatesAutoresizingMaskIntoConstraints = false
        pro.layer.masksToBounds = true
        pro.clipsToBounds = true
        pro.layer.cornerRadius = 12
        pro.progressTintColor = UIColor(red: 12 / 255, green: 205 / 255, blue: 213 / 255, alpha: 1)
        return pro
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
    
    fileprivate func fillInfos() {
        studImageView.image = studentPicture
        if let firstName = student.firstName, let lastName = student.lastName {
            nameLabel.text = firstName + " " + lastName
        }
        if let login = student.login {
            loginLabel.text = login
        }
        if let email = student.email {
            emailLabel.text = email
        }
        if let phone = student.phone {
            phoneLabel.text = phone
        }
        if let curses = student.cursus, curses.count >= 1, let grade = curses[0].grade {
            gradeLabel.text = grade
        }
        if let curses = student.cursus, curses.count >= 1, let level = curses[0].level {
            let ent = Int(floor(Double(level)))
            let percent = level - Float(ent)
            levelLabel.text = "level: " + String(ent) + " - " + String(Int(percent * 100)) + "%"
            progressBar.progress = percent
        }
        
    }
    
    func            setupView() {
        
        fillInfos()
        
        view.addSubview(studImageView)
        view.addSubview(nameLabel)
        view.addSubview(loginLabel)
        view.addSubview(emailLabel)
        view.addSubview(phoneLabel)
        view.addSubview(progressBar)
        view.addSubview(levelLabel)
        view.addSubview(gradeLabel)
        
        view.addSubview(downButton)
        
        downButton.addTarget(self, action: #selector(backToSearch), for: .touchUpInside)
        NSLayoutConstraint.activate([
            studImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            studImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 27),
            studImageView.widthAnchor.constraint(equalToConstant: 120),
            studImageView.heightAnchor.constraint(equalToConstant: 120),
            
            downButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            downButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downButton.widthAnchor.constraint(equalToConstant: 44),
            downButton.heightAnchor.constraint(equalToConstant: 44),
            
            loginLabel.topAnchor.constraint(equalTo: studImageView.topAnchor, constant: 8),
            loginLabel.leadingAnchor.constraint(equalTo: studImageView.trailingAnchor, constant: 27),
            loginLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            loginLabel.heightAnchor.constraint(equalToConstant: 26),
            
            nameLabel.topAnchor.constraint(equalTo: loginLabel.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: loginLabel.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nameLabel.heightAnchor.constraint(equalToConstant: 26),
            
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            emailLabel.leadingAnchor.constraint(equalTo: loginLabel.leadingAnchor),
            emailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            emailLabel.heightAnchor.constraint(equalToConstant: 26),
            
            phoneLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor),
            phoneLabel.leadingAnchor.constraint(equalTo: loginLabel.leadingAnchor),
            phoneLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            phoneLabel.heightAnchor.constraint(equalToConstant: 26),
            
            gradeLabel.topAnchor.constraint(equalTo: studImageView.bottomAnchor, constant: 24),
            gradeLabel.leadingAnchor.constraint(equalTo: studImageView.leadingAnchor),
            gradeLabel.trailingAnchor.constraint(equalTo: studImageView.trailingAnchor),
            gradeLabel.heightAnchor.constraint(equalToConstant: 26),
            
            progressBar.topAnchor.constraint(equalTo: gradeLabel.bottomAnchor, constant: 10),
            progressBar.leadingAnchor.constraint(equalTo: studImageView.leadingAnchor),
            progressBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -27),
            progressBar.heightAnchor.constraint(equalToConstant: 24),
            
            levelLabel.centerXAnchor.constraint(equalTo: progressBar.centerXAnchor),
            levelLabel.centerYAnchor.constraint(equalTo: progressBar.centerYAnchor),
            levelLabel.widthAnchor.constraint(equalToConstant: 200),
            levelLabel.heightAnchor.constraint(equalToConstant: 26),
            
            
            
            
        ])
    }
}
