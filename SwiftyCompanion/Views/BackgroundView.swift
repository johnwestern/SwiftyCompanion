//
//  BackgroundView.swift
//  SwiftyCompanion
//
//  Created by Jonathan DAVIN on 1/23/19.
//  Copyright © 2019 Jonathan DAVIN. All rights reserved.
//

import UIKit

class                   BackgroundView: UIView
{
    var                 topConstraint: NSLayoutConstraint?
    var                 bottomConstraint: NSLayoutConstraint?
    let                 root: SearchStudentController

    init(frame: CGRect, root: SearchStudentController) {
        self.root = root
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
    let                 blurEffectView: UIVisualEffectView = {
        let             visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        visualEffectView.isUserInteractionEnabled = false
        visualEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        return visualEffectView
    }()
    
    func                animateLogoUp() {
        let             offset = frame.height * 0.5 - frame.height * 0.30
        
        UIView.animate(withDuration: 1, delay: 0.25, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.logoImageView.transform = CGAffineTransform(translationX: 0, y: -offset)
        })
        UIView.animate(withDuration: 0.7, delay: 0.5, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.root.loginContainer.alpha = 1
            self.root.searchButton.alpha = 1
        })
    }
    
    func                animateLogoDown() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.logoImageView.transform = .identity
        })
    }
    
    func                handleAnimation() {
        blurEffectView.alpha = 0
        logoImageView.alpha = 0
        
        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveEaseOut, animations: {
            self.blurEffectView.alpha = 0.9
            self.topConstraint?.constant = -100
            self.bottomConstraint?.constant = 100
            self.layoutIfNeeded()
            
        }) { (true) in
            self.backgroundImageView.rotate360Degrees(duration: 125)
            UIView.animate(withDuration: 0.5, animations: {
                self.logoImageView.alpha = 1
                self.animateLogoUp()
            })
        }
    }
    
    func                setupView() {
        addSubview(backgroundImageView)
        addSubview(blurEffectView)
        addSubview(logoImageView)
        
        blurEffectView.frame = frame
        backgroundImageView.frame = frame
        
        topConstraint = backgroundImageView.topAnchor.constraint(equalTo: topAnchor)
        bottomConstraint = backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        NSLayoutConstraint.activate([
            topConstraint!, bottomConstraint!,
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            logoImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: frame.width - 100),
            logoImageView.heightAnchor.constraint(equalToConstant: 130)
        ])
        handleAnimation()
    }
}

extension UIView {
    func rotate360Degrees(duration: CFTimeInterval = 3) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(Double.pi * 2)
        rotateAnimation.isRemovedOnCompletion = false
        rotateAnimation.duration = duration
        rotateAnimation.repeatCount=Float.infinity
        self.layer.add(rotateAnimation, forKey: nil)
    }
}
