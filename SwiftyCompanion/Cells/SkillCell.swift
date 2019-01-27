//
//  SkillCell.swift
//  SwiftyCompanion
//
//  Created by jdavin on 27/01/2019.
//  Copyright © 2019 Jonathan DAVIN. All rights reserved.
//

import UIKit

class           SkillCell: UICollectionViewCell {
    var         skill: Skill? {
        didSet {
            setupViews()
        }
    }
    
    let levelLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let skillLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func levelToString(_ level: Float) -> String {
        let ent = Int(floor(Double(level)))
        return "lvl: " + String(ent)
    }
    
    fileprivate func fillRightSkill(_ skillName: String) {
        switch skillName {
        case "Algorithms & AI":
            skillLabel.text = "AI"
        case "Company experience":
            skillLabel.text = "company"
        case "Adaptation & creativity":
            skillLabel.text = "creative"
        case "Graphics":
            skillLabel.text = "graph"
        case "Security":
            skillLabel.text = "secu"
        case "Rigor":
            skillLabel.text = "rigor"
        case "Unix":
            skillLabel.text = "unix"
        case "Technology integration":
            skillLabel.text = "tech inte"
        case "Imperative programming":
            skillLabel.text = "Imp prog"
        case "Organization":
            skillLabel.text = "orga"
        case "DB & Data":
            skillLabel.text = "DB"
        case "Web":
            skillLabel.text = "web"
        case "Group & interpersonal":
            skillLabel.text = "group"
        case "Object-oriented programming":
            skillLabel.text = "obj prog"
        case "Parallel computing":
            skillLabel.text = "para comp"
        default:
            skillLabel.text = skillName
        }
    }
    
    func setupViews() {
        backgroundColor = .clear
        let progressCircle = ProgressCircleView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        progressCircle.updateProgress(CGFloat(skill!.level! - Float(Int(floor(Double(skill!.level!))))))
        levelLabel.text = levelToString(skill!.level!)
        fillRightSkill(skill!.name!)
        addSubview(progressCircle)
        addSubview(levelLabel)
        addSubview(skillLabel)
        
        NSLayoutConstraint.activate([
            levelLabel.topAnchor.constraint(equalTo: progressCircle.topAnchor),
            levelLabel.bottomAnchor.constraint(equalTo: progressCircle.bottomAnchor),
            levelLabel.leadingAnchor.constraint(equalTo: progressCircle.leadingAnchor),
            levelLabel.trailingAnchor.constraint(equalTo: progressCircle.trailingAnchor),
            
            skillLabel.topAnchor.constraint(equalTo: progressCircle.bottomAnchor),
            skillLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            skillLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            skillLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
}
