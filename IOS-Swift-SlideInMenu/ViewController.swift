//
//  ViewController.swift
//  IOS-Swift-SlideInMenu
//
//  Created by Pooya on 2018-06-08.
//  Copyright © 2018 Pooya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var buttonView: UIButton!
    @IBOutlet weak var segOption: UISegmentedControl!
    
    let slideInHandler = SlideInHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slideInHandler.selectionDelegate = self
        buttonView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSlideInMenu)))
    
    }

    @objc func handleSlideInMenu()  {
        var  thisMenuLocation : MenuLocationOption
        switch self.segOption.titleForSegment(at: segOption.selectedSegmentIndex)! {
        case "Top":
            thisMenuLocation = .TOP
        case "Left":
            thisMenuLocation = .Left
        case "Right":
            thisMenuLocation = .Right
        case "Bottom":
            thisMenuLocation = .Bottom
        default:
            thisMenuLocation = .Left
        }
        
        var myMenuSetting : [Setting] = []
        myMenuSetting.append(Setting(name: "New", imageName: "addicon32x32"))
        myMenuSetting.append(Setting(name: "Help", imageName: "Helpicon32x32"))
        myMenuSetting.append(Setting(name: "Send", imageName: "Send32x32"))
        myMenuSetting.append(Setting(name: "Save", imageName: "save32x32"))
        myMenuSetting.append(Setting(name: "Settings", imageName: "Settings32x32"))
        myMenuSetting.append(Setting(name: "Lock", imageName: "Lock32x32"))
        myMenuSetting.append(Setting(name: "Cancel", imageName: "Cancel32x32"))
        
        slideInHandler.settings = myMenuSetting
        slideInHandler.menuBackColor = UIColor.yellow
    
        slideInHandler.showSlideInMenu(menuSide: thisMenuLocation)
    }
    
}


extension ViewController: SelectionDelegate {
    func didTapSelect(menuSelection: String, description: String) {
        print("Selection: \(menuSelection)")
        //TODO: triger action for selection
    }
    
}
