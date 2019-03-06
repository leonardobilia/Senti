//
//  Lottie.swift
//  Senti
//
//  Created by Leonardo Bilia on 3/4/19.
//  Copyright © 2019 Leonardo Bilia. All rights reserved.
//

import Foundation
import Lottie

struct Lottie {
    private init() {}
    
    static private var currentOverlay : UIView?
    static private var currentOverlayTarget : UIView?
    
    enum Animation: String {
        case spinner = "spinner"
    }

    static func show(_ animation: Animation, size: CGFloat, completion: (()->())?) {
        show(animation, overlayTarget: nil, size: size, loop: false) { completion?() }
    }
    
    static func show(_ animation: Animation, size: CGFloat) {
        show(animation, overlayTarget: nil, size: size, loop: true, completion: nil)
    }
    
    static func show(_ animation: Animation, overlayTarget: UIView, size: CGFloat, completion: (()->())?) {
        show(animation, overlayTarget: overlayTarget, size: size, loop: false) { completion?() }
    }
    
    static func show(_ animation: Animation, overlayTarget: UIView, size: CGFloat) {
        show(animation, overlayTarget: overlayTarget, size: size, loop: true, completion: nil)
    }
    
    static private func show(_ animation: Animation, overlayTarget: UIView?, size: CGFloat, loop: Bool, completion: (()->())?) {
        hide()
        
        guard let window = UIApplication.shared.keyWindow else { return }
        var overlay = UIView()
        
        if let overlayTarget = overlayTarget {
            overlay = UIView(frame: overlayTarget.frame)
            overlay.center = overlayTarget.center
            overlay.alpha = 0
            overlay.backgroundColor = .darkGray
            overlayTarget.addSubview(overlay)
            overlayTarget.bringSubviewToFront(overlay)
            
        } else {
            overlay = UIView(frame: window.frame)
            overlay.center = window.center
            overlay.alpha = 0
            overlay.backgroundColor = UIColor(white: 0, alpha: 0.6)
            window.addSubview(overlay)
            window.bringSubviewToFront(overlay)
            
            let cardView = UIView()
            cardView.layer.cornerRadius = 32
            cardView.layer.masksToBounds = true
            cardView.translatesAutoresizingMaskIntoConstraints = false
            
            overlay.addSubview(cardView)
            cardView.centerXAnchor.constraint(equalTo: overlay.centerXAnchor).isActive = true
            cardView.centerYAnchor.constraint(equalTo: overlay.centerYAnchor).isActive = true
            cardView.widthAnchor.constraint(equalToConstant: 260).isActive = true
            cardView.heightAnchor.constraint(equalToConstant: 260).isActive = true
            
            let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = cardView.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            cardView.addSubview(blurEffectView)
        }
        
        let animationView = LOTAnimationView(name: animation.rawValue)
        animationView.contentMode = .scaleAspectFit
        animationView.loopAnimation = loop
        animationView.autoReverseAnimation = true
        
        if loop {
            animationView.play()
            
        } else {
            animationView.play { (completed) in
                completion?()
                hide()
            }
        }
        
        overlay.addSubview(animationView)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.centerXAnchor.constraint(equalTo: overlay.centerXAnchor).isActive = true
        animationView.centerYAnchor.constraint(equalTo: overlay.centerYAnchor).isActive = true
        animationView.widthAnchor.constraint(equalToConstant: size).isActive = true
        animationView.heightAnchor.constraint(equalToConstant: size).isActive = true
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.5)
        overlay.alpha = overlay.alpha > 0 ? 0 : 1
        UIView.commitAnimations()
        
        currentOverlay = overlay
        currentOverlayTarget = overlayTarget
    }
    
    static func hide() {
        if currentOverlay != nil {
            currentOverlay?.removeFromSuperview()
            currentOverlay =  nil
            currentOverlayTarget = nil
        }
    }
}
