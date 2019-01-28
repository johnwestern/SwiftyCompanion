//
//  ProjectCell.swift
//  SwiftyCompanion
//
//  Created by jdavin on 28/01/2019.
//  Copyright © 2019 Jonathan DAVIN. All rights reserved.
//

import UIKit

class               ProjectCell: UITableViewCell {
    
    var             project: EZProject? {
        didSet {
            setupView()
            nameLabel.text = project?.name
            markLabel.text = String(project!.finalMark!)
            markLabel.textColor = project!.valid! ? .green : .red
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let markLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let             separatorView: UIView = {
        let         view = UIView()
        
        view.backgroundColor = UIColor(white: 0.7, alpha: 0.7)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    fileprivate func setupView() {
        backgroundColor = .clear
        
        addSubview(separatorView)
        addSubview(nameLabel)
        addSubview(markLabel)
        
        NSLayoutConstraint.activate([
            separatorView.topAnchor.constraint(equalTo: topAnchor),
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -75),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            markLabel.topAnchor.constraint(equalTo: topAnchor),
            markLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            markLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            markLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
