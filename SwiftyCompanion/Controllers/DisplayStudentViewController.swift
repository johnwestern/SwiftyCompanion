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
    
    let             headerHeight: CGFloat = 224
    
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
    var             maxOffset: CGFloat = -240.0
    
    override func   viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: view.frame)
        tableView?.separatorStyle = .none
        tableView?.alwaysBounceVertical = true
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
    
    let             coverView: UIVisualEffectView = {
        let         visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        visualEffectView.isUserInteractionEnabled = false
        visualEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        return visualEffectView
    }()
    
    func            setupView() {
        studentHeaderView = StudentHeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 168), studentPic: studentPicture, student: student)
        studentHeaderView?.translatesAutoresizingMaskIntoConstraints = false
        studentHeaderView?.clipsToBounds = true
        
        view.addSubview(studentHeaderView!)
        view.addSubview(tableView!)
        view.addSubview(downButton)
        studentHeaderView?.addSubview(coverView)
        
        downButton.addTarget(self, action: #selector(backToSearch), for: .touchUpInside)
        NSLayoutConstraint.activate([
            downButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -38),
            downButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downButton.widthAnchor.constraint(equalToConstant: 40),
            downButton.heightAnchor.constraint(equalToConstant: 40),
            
            studentHeaderView!.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            studentHeaderView!.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            studentHeaderView!.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            studentHeaderView!.heightAnchor.constraint(equalToConstant: 168),
            
            coverView.topAnchor.constraint(equalTo: studentHeaderView!.topAnchor),
            coverView.bottomAnchor.constraint(equalTo: studentHeaderView!.bottomAnchor),
            coverView.leadingAnchor.constraint(equalTo: studentHeaderView!.leadingAnchor),
            coverView.trailingAnchor.constraint(equalTo: studentHeaderView!.trailingAnchor)
        ])
    }
    
    var maxOffsetSet = false
}

extension       DisplayStudentViewController {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            maxOffset = maxOffsetSet ? maxOffset : self.tableView!.contentOffset.y
            return 190.0
        }
        return 50
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard tableView != nil, studentHeaderView != nil else { return }
        print(coverView.frame.minY)
        print(-maxOffset + (maxOffset - tableView!.contentOffset.y) - studentHeaderView!.frame.minY)
        var delta = -maxOffset + (maxOffset - tableView!.contentOffset.y) - studentHeaderView!.frame.minY
        delta = delta < 0 ? 0 : delta
        coverView.transform = CGAffineTransform(translationX: 0, y: delta)
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
        return 1
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
