//
//  AnimationTableViewCell.swift
//  Unit4FinalAssessment-StudentVersion
//
//  Created by C4Q on 1/12/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class AnimationTableViewCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "AnimationSettingsCell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func commonInit() {
        backgroundColor = .white
        setupViews()
    }
    
    private func setupViews() {
        setupStepper()
        setupLabel()
    }
    
    lazy var settingLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()
    
    lazy var stepper: UIStepper = {
        let stepper = UIStepper()
        stepper.isContinuous = false
        return stepper
    }()
    
    func configureCell(with animationProperty: AnimationProperty, for cell: AnimationTableViewCell) {
        commonInit()
        stepper.value = Double(animationProperty.startingStepperVal)
        stepper.stepValue = Double(animationProperty.stepperIncrement)
        stepper.minimumValue = Double(animationProperty.stepperMin)
        stepper.maximumValue = Double(animationProperty.stepperMax)
        settingLabel.text = "\(animationProperty.name.rawValue): \(stepper.value)"

        switch animationProperty.name.rawValue {
        case "Width Multiplier":
            stepper.tag = 0
            print("stepper 0")
        case "Height Multiplier":
            stepper.tag = 1
            print("stepper 1")
        case "Horizontal Position":
            stepper.tag = 2
            print("stepper 2")
        case "Vertical Position":
            stepper.tag = 3
            print("stepper 3")
        case "Number of Flips":
            stepper.tag = 4
            print("stepper 4")
        default:
            break
        }
        print(stepper.value)
    }
    
    func setupStepper() {
        addSubview(stepper)
        stepper.translatesAutoresizingMaskIntoConstraints = false
        [stepper.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
         stepper.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)]
            .forEach{$0.isActive = true}
    }
    
    func setupLabel() {
        addSubview(settingLabel)
        settingLabel.translatesAutoresizingMaskIntoConstraints = false
        [settingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
        settingLabel.centerYAnchor.constraint(equalTo: centerYAnchor)]
            .forEach{$0.isActive = true}
    }
}
