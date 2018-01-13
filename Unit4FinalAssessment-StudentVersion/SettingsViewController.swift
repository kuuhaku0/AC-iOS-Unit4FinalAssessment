//
//  SettingsViewController.swift
//  Unit4FinalAssessment-StudentVersion
//
//  Created by C4Q  on 1/11/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

enum PropertyName: String {
    case widthMultiplier = "Width Multiplier"
    case heightMultiplier = "Height Multiplier"
    case horizontalPosition = "Horizontal Position"
    case verticalPosition = "Vertical Position"
    case numberOfFlips = "Number of Flips"
    //TO DO: Add other PropertyName Cases
}

struct AnimationProperty {
    let name: PropertyName
    let stepperMin: Float
    let stepperMax: Float
    let stepperIncrement: Float
    var startingStepperVal: Float
}

struct Animation: Codable {
    var animationName: String
    var width: Double
    var height: Double
    var horizontal: Double
    var vertical: Double
    var flips: Double
}

class SettingsViewController: UIViewController {
    
    let animVC = AnimationViewController()
    
    var settingsToSave = Animation(animationName: "", width: 0, height: 0, horizontal: 0, vertical: 0, flips: 0) {
        didSet {
            print(settingsToSave)
        }
    }
    
    var properties: [[AnimationProperty]] =
    [
        [AnimationProperty(name: .widthMultiplier, stepperMin: 0, stepperMax: 1, stepperIncrement: 0.1, startingStepperVal: 0.0),
         AnimationProperty(name: .heightMultiplier, stepperMin: 0, stepperMax: 1.0, stepperIncrement: 0.1, startingStepperVal: 0.0)],
        
        [AnimationProperty(name: .horizontalPosition, stepperMin: -100, stepperMax: 100, stepperIncrement: 20, startingStepperVal: 0),
         AnimationProperty(name: .verticalPosition, stepperMin: -100, stepperMax: 100, stepperIncrement: 20, startingStepperVal: 0)],
        
        [AnimationProperty(name: .numberOfFlips, stepperMin: 0, stepperMax: 10, stepperIncrement: 1, startingStepperVal: 0)]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        layoutTableView()
        configureNavBar()
    }
    
    func layoutTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.register(AnimationTableViewCell.self, forCellReuseIdentifier: "AnimationSettingsCell")
        tv.dataSource = self
        tv.delegate = self
        return tv
    }()
    
    private func configureNavBar() {
        navigationItem.title = "Settings"
        let createNewAnim = UIBarButtonItem(title: "New", style: .plain, target: self, action: #selector(createNewAnimation))
        navigationItem.rightBarButtonItem = createNewAnim
    }
    
    @objc func createNewAnimation() {
        let alert = UIAlertController(title: "Create Animation", message: "Enter a name for new animation", preferredStyle: .alert)
        alert.addTextField(configurationHandler: {(textField) in
            textField.borderStyle = .roundedRect
            textField.placeholder = "Animation Name"
            textField.textAlignment = .center
        })
        
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: {(saveAnimation) in
            guard !(alert.textFields?.first?.text?.isEmpty)! else {
                alert.message = "Name cannot be blank"
                return
            }
            self.settingsToSave.animationName = (alert.textFields?.first?.text)!
            saveAnimation.isEnabled = true
            self.saveNewAnimation()
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    func saveNewAnimation() {
        DataStore.manager.addToCustomAnimations(animation: settingsToSave)
        settingsToSave = Animation(animationName: "", width: 0, height: 0, horizontal: 0, vertical: 0, flips: 0)
    }

    @objc func stepperValueChanged(sender: UIStepper) {
        print(sender.value)
        switch sender.tag {
        case 0:
            settingsToSave.width = sender.value
        case 1:
            settingsToSave.height = sender.value
//            cell.settingLabel.text = "Height Multiplier: \(sender.value)"
        case 2:
            settingsToSave.horizontal = sender.value
//            cell.settingLabel.text = "Horizontal Position: \(sender.value)"
        case 3:
            settingsToSave.vertical = sender.value
//            cell.settingLabel.text = "Vertical Position: \(sender.value)"
        case 4:
            settingsToSave.flips = sender.value
//            cell.settingLabel.text = "Number of Flips: \(sender.value)"
        default:
            settingsToSave.flips = 0
            settingsToSave.height = 0
            settingsToSave.horizontal = 0
            settingsToSave.vertical = 0
            settingsToSave.width = 0
            print("unsaved")
        }
    }
}

extension SettingsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return properties.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let property = properties[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnimationSettingsCell", for: indexPath) as!
            AnimationTableViewCell
        cell.configureCell(with: property, for: cell)
        cell.stepper.addTarget(self, action: #selector(stepperValueChanged), for: .valueChanged)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return properties[section].count
    }
}

extension SettingsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Size Settings"
        case 1:
            return "Position Settings"
        default:
            return "Other Settings"
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension SettingsViewController {
    
}









