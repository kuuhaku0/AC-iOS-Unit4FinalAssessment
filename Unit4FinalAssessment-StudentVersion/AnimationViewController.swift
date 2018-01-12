//
//  AnimationViewController.swift
//  Unit4FinalAssessment-StudentVersion
//
//  Created by C4Q  on 1/11/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class AnimationViewController: UIViewController {
    
    var selectedAnimation: Animation!
    
    let animationView = AnimationView()
    
    var isAnimating = false
    
    var pickerData = [[Animation(animationName: "Default", width: 1, height: 1, horizontal: 0, vertical: 0, flips: 1)]]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        for animation in DataStore.manager.getAnimations() {
            pickerData.append([animation])
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animationView.pickerView.delegate = self
        animationView.pickerView.dataSource = self
        selectedAnimation = pickerData.first?.first
        self.view.backgroundColor = UIColor(red: 0.6, green: 0.6, blue: 0.9, alpha: 1.0)
        view.addSubview(animationView)
        animationView.pauseAndPlayButton.addTarget(self, action: #selector(pausePlay), for: .touchUpInside)
    }
    
    @objc func pausePlay() {
        if isAnimating == false {
            performAnimations(with: selectedAnimation)
            isAnimating = true
        }
        let layer = animationView.imageView.layer
        if animationView.imageView.layer.speed == 1 {
            let pausedTime = animationView.imageView.layer.convertTime(CACurrentMediaTime(), from: nil)
            animationView.imageView.layer.speed = 0
            animationView.imageView.layer.timeOffset = pausedTime
        }
            // resume
        else {
            let pausedTime = animationView.imageView.layer.timeOffset
            animationView.imageView.layer.speed = 1
            animationView.imageView.layer.timeOffset = 0
            animationView.imageView.layer.beginTime = 0
            let timeSincePause = imageView.layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
            animationView.imageView.layer.beginTime = timeSincePause
        }
    }
}

extension AnimationViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 0 {
            selectedAnimation = pickerData[row].first
        }
        else {
            selectedAnimation = DataStore.manager.getAnimations()[row - 1]
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        print(pickerData.count)
        return DataStore.manager.getAnimations().count + 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if row == 0 {
            return pickerData[row].first?.animationName
        }
        else {
            return DataStore.manager.getAnimations()[row - 1].animationName
        }
    }
}

extension AnimationViewController {
    func performAnimations(with values: Animation) {
        let animation = CABasicAnimation(keyPath: "transform.rotation.x")
        let angleRadian = CGFloat(2.0 * .pi) // 360
        animation.fromValue = 0 // degrees
        animation.byValue = angleRadian
        animation.duration = 5.0 // seconds
        animation.repeatCount = 1
        animation.delegate = self
        animationView.imageView.layer.add(animation, forKey: nil)
    }
}

extension AnimationViewController: CAAnimationDelegate {
    func animationDidStart(_ anim: CAAnimation) {
        print("animationDidStart: \(anim.description)")
        animationView.pauseAndPlayButton.setTitle("Pause", for: .normal)
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        print("animationDidStop: \(anim.description) finshed: \(flag)")
        animationView.pauseAndPlayButton.setTitle("Play", for: .normal)
        isAnimating = false
    }
}
