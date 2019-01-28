//
//  ProgressCircleView.swift
//  SwiftyCompanion
//
//  Created by jdavin on 27/01/2019.
//  Copyright © 2019 Jonathan DAVIN. All rights reserved.
//

import UIKit

class ProgressCircleView: UIView {
    let shapeLayer = CAShapeLayer()
    let trackLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateProgress(_ progress: CGFloat) {
        shapeLayer.strokeEnd = progress
    }
    
    fileprivate func setupView() {
        
        //create track layer
        let track = UIBezierPath(arcCenter: center, radius: 45, startAngle: -0.5 * .pi, endAngle: 1.5 * .pi, clockwise: true)
        trackLayer.path = track.cgPath
        trackLayer.strokeColor = UIColor(white: 0.6, alpha: 0.65).cgColor
        trackLayer.lineWidth = 10
        trackLayer.strokeEnd = 1
        trackLayer.fillColor = UIColor.clear.cgColor
        
        
        //progress circle
        let circularPath = UIBezierPath(arcCenter: center, radius: 45, startAngle: -0.5 * .pi, endAngle: 1.5 * .pi, clockwise: true)
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor.swifty.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.strokeEnd = 0
        shapeLayer.fillColor = UIColor.clear.cgColor
        
        layer.addSublayer(trackLayer)
        layer.addSublayer(shapeLayer)
        
    }
}
