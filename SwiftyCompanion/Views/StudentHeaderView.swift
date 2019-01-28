//
//  StudentHeaderView.swift
//  SwiftyCompanion
//
//  Created by Jonathan DAVIN on 1/25/19.
//  Copyright © 2019 Jonathan DAVIN. All rights reserved.
//

import UIKit

class                       StudentHeaderView: UIView {
    let                     studentPicture: UIImage
    let                     student: Student
    
    let             studImageView: UIImageView = {
        let          iv = UIImageView()
        
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.masksToBounds = true
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 50
        iv.layer.borderColor = UIColor(red: 12 / 255, green: 205 / 255, blue: 213 / 255, alpha: 1).cgColor
        iv.layer.borderWidth = 2
        iv.contentMode = .scaleAspectFill
        return iv
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
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
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
    
    let walletLabel: UILabel = {
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
        pro.layer.cornerRadius = 11
        pro.progressTintColor = .swifty
        return pro
    }()
    
    init(frame: CGRect, studentPic: UIImage, student: Student) {
        self.student = student
        self.studentPicture = studentPic
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        if var phone = student.phone {
            phone = phone.replacingOccurrences(of: "+33", with: "0")
            if phone.count == 10 {
                phone = phone.inserting(separator: " ", every: 2)
            }
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
        if let wallet = student.wallet {
            walletLabel.text = String(wallet) + "₳"
        }
    }

    fileprivate func        setupView() {
        fillInfos()
        
        addSubview(studImageView)
        addSubview(nameLabel)
        addSubview(loginLabel)
        addSubview(emailLabel)
        addSubview(phoneLabel)
        addSubview(progressBar)
        addSubview(levelLabel)
        addSubview(gradeLabel)
        addSubview(walletLabel)
        
        NSLayoutConstraint.activate([
            studImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 24),
            studImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 27),
            studImageView.widthAnchor.constraint(equalToConstant: 100),
            studImageView.heightAnchor.constraint(equalToConstant: 100),
            
            loginLabel.topAnchor.constraint(equalTo: studImageView.topAnchor, constant: 8),
            loginLabel.leadingAnchor.constraint(equalTo: studImageView.trailingAnchor, constant: 27),
            loginLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            loginLabel.heightAnchor.constraint(equalToConstant: 23),
            
            nameLabel.topAnchor.constraint(equalTo: loginLabel.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: loginLabel.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            nameLabel.heightAnchor.constraint(equalToConstant: 23),
            
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            emailLabel.leadingAnchor.constraint(equalTo: loginLabel.leadingAnchor),
            emailLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            emailLabel.heightAnchor.constraint(equalToConstant: 23),
            
            phoneLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor),
            phoneLabel.leadingAnchor.constraint(equalTo: loginLabel.leadingAnchor),
            phoneLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            phoneLabel.heightAnchor.constraint(equalToConstant: 23),
            
            gradeLabel.topAnchor.constraint(equalTo: studImageView.bottomAnchor, constant: 10),
            gradeLabel.leadingAnchor.constraint(equalTo: studImageView.leadingAnchor),
            gradeLabel.trailingAnchor.constraint(equalTo: progressBar.centerXAnchor),
            gradeLabel.heightAnchor.constraint(equalToConstant: 26),
            
            walletLabel.topAnchor.constraint(equalTo: studImageView.bottomAnchor, constant: 10),
            walletLabel.leadingAnchor.constraint(equalTo: gradeLabel.trailingAnchor),
            walletLabel.trailingAnchor.constraint(equalTo: progressBar.trailingAnchor),
            walletLabel.heightAnchor.constraint(equalToConstant: 26),
            
            progressBar.topAnchor.constraint(equalTo: gradeLabel.bottomAnchor, constant: 10),
            progressBar.leadingAnchor.constraint(equalTo: studImageView.leadingAnchor),
            progressBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -27),
            progressBar.heightAnchor.constraint(equalToConstant: 22),
            
            levelLabel.centerXAnchor.constraint(equalTo: progressBar.centerXAnchor),
            levelLabel.centerYAnchor.constraint(equalTo: progressBar.centerYAnchor),
            levelLabel.widthAnchor.constraint(equalToConstant: 200),
            levelLabel.heightAnchor.constraint(equalToConstant: 22),
        ])
    }
}
