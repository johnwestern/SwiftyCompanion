//
//  DisplayStudentViewController.swift
//  SwiftyCompanion
//
//  Created by jdavin on 24/01/2019.
//  Copyright © 2019 Jonathan DAVIN. All rights reserved.
//

import UIKit

class               DisplayStudentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    let             studentPicture: UIImage
    let             student: Student
    let             rootVC: SearchStudentController
    var             studentHeaderView: StudentHeaderView?
    var             tableView: UITableView?
    
    let             headerHeight: CGFloat = 200
    
    let             downButton: UIButton = {
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
    
    private let     cellId = "cellId"
    private let     skillCellId = "skillCellId"
    
    override func   viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: view.frame)
        tableView?.separatorStyle = .none
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.contentInset = UIEdgeInsets(top: headerHeight, left: 0, bottom: 45, right: 0)
        tableView?.contentOffset = CGPoint(x: 0, y: -headerHeight)
        
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tableView?.register(SkillsCell.self, forCellReuseIdentifier: skillCellId)
        tableView?.backgroundColor = .clear
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
        studentHeaderView = StudentHeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 168), studentPic: studentPicture, student: student)
        studentHeaderView?.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(studentHeaderView!)
        view.addSubview(tableView!)
        view.addSubview(downButton)
        
        downButton.addTarget(self, action: #selector(backToSearch), for: .touchUpInside)
        NSLayoutConstraint.activate([
            downButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -38),
            downButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downButton.widthAnchor.constraint(equalToConstant: 40),
            downButton.heightAnchor.constraint(equalToConstant: 40),
            
            studentHeaderView!.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            studentHeaderView!.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            studentHeaderView!.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            studentHeaderView!.heightAnchor.constraint(equalToConstant: 168),
        ])
    }
}

extension       DisplayStudentViewController {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 190.0
        }
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: skillCellId, for: indexPath) as! SkillsCell
            cell.skills = student.cursus![0].skills
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
            cell.textLabel?.text = "Ceci est un test"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        return
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
}

extension StringProtocol where Self: RangeReplaceableCollection {
    mutating func insert(separator: String, every n: Int) {
        indices.reversed().forEach {
            if $0 != startIndex { if Int(distance(from: startIndex, to: $0)) % n == 0 { insert(contentsOf: separator, at: $0) } }
        }
    }
    func inserting(separator: String, every n: Int) -> Self {
        var string = self
        string.insert(separator: separator, every: n)
        return string
    }
}
