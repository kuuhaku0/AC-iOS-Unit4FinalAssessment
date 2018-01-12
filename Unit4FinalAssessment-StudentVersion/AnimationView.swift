//
//  AnimationView.swift
//  Unit4FinalAssessment-StudentVersion
//
//  Created by C4Q on 1/12/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class AnimationView: UIView {

    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .white
        setupViews()
    }
    
    private func setupViews() {
        setupImageView()
        setupButton()
        setupPickerView()
    }
    
    //ALL UI ELEMENT
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "snowman")
        return imageView
    }()
    
    lazy var pickerView: UIPickerView = {
        let pv = UIPickerView()
        return pv
    }()
    
    lazy var pauseAndPlayButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.setTitle("Play", for: .normal)
        return button
    }()
    
    func setupImageView() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        [imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
         imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
         imageView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.6),
         imageView.widthAnchor.constraint(equalTo: widthAnchor, constant: -32)]
            .forEach{$0.isActive = true}
    }
    
    func setupPickerView() {
        addSubview(pickerView)
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        [pickerView.centerXAnchor.constraint(equalTo: centerXAnchor),
         pickerView.topAnchor.constraint(equalTo: imageView.bottomAnchor),
         pickerView.bottomAnchor.constraint(equalTo: pauseAndPlayButton.topAnchor)]
            .forEach{$0.isActive = true}
    }
    
    func setupButton() {
        addSubview(pauseAndPlayButton)
        pauseAndPlayButton.translatesAutoresizingMaskIntoConstraints = false
        [pauseAndPlayButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8),
         pauseAndPlayButton.centerXAnchor.constraint(equalTo: centerXAnchor)]
            .forEach{$0.isActive = true}
    }

}
