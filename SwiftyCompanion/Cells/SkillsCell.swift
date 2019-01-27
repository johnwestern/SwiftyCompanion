//
//  SkillsCell.swift
//  SwiftyCompanion
//
//  Created by Jonathan DAVIN on 1/25/19.
//  Copyright © 2019 Jonathan DAVIN. All rights reserved.
//

import UIKit

class SkillsCell: UITableViewCell {
    
    var skills: [Skill]? {
        didSet {
            setupView()
        }
    }
    
    let label: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = "Skills"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    var skillsCollectionView: SkillsCollectionView?
    
    fileprivate func setupView() {
        backgroundColor = .clear
        skillsCollectionView?.removeFromSuperview()
        skillsCollectionView = SkillsCollectionView(skills!, .horizontal)
        skillsCollectionView!.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(label)
        addSubview(skillsCollectionView!)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.heightAnchor.constraint(equalToConstant: 40),
            skillsCollectionView!.topAnchor.constraint(equalTo: label.bottomAnchor),
            skillsCollectionView!.leadingAnchor.constraint(equalTo: leadingAnchor),
            skillsCollectionView!.trailingAnchor.constraint(equalTo: trailingAnchor),
            skillsCollectionView!.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
