//
//  slideInHandler.swift
//  IOS-Swift-SlideInMenu
//
//  Created by Pooya on 2018-06-08.
//  Copyright © 2018 Pooya. All rights reserved.
//

import UIKit

class SlideInHandler: NSObject , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    override init() {
        super.init()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(SettingCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    struct MenuLocation {
        var width : CGFloat = 0
        var height : CGFloat = 0
        var xTo : CGFloat = 0
        var yTo : CGFloat = 0
        var xFrom : CGFloat = 0
        var yFrom : CGFloat = 0
    }
    
    let blackView = UIView()
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero , collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        return cv
    }()
    
    var selectionDelegate : SelectionDelegate!
    
    var cellId = "cellId"
    var menuCellheight : CGFloat = 50
    var menuCellWidth : CGFloat = 200
    var menuIconsSize : CGFloat = 32
    var menuCellsBackColor  = UIColor.clear
    var menuHighlightColor  = UIColor.darkGray
    var menuCellsTextColor  = UIColor.black
    var menuBackColor  = UIColor.white
    var mainMenuSize : CGFloat?
    var MainMenuSide : MenuLocationOption = .Left
    var settings:[Setting] = {
        return [Setting(name: "No Menu Cell Yet ?", imageName: "?")]
    }()
//    var settings:[Setting] = {
//       return [Setting(name: "New", imageName: "addicon32x32"),
//               Setting(name: "Help", imageName: "Helpicon32x32"),
//               Setting(name: "Send", imageName: "Send32x32"),
//                Setting(name: "Save", imageName: "save32x32"),
//                Setting(name: "Settings", imageName: "Settings32x32"),
//               Setting(name: "Lock", imageName: "Lock32x32"),
//               Setting(name: "Cancel", imageName: "Cancel32x32")]
//    }()
    
    
    func showSlideInMenu(menuSide: MenuLocationOption = .Left) {
        //mainMenuSize = menuSize
        MainMenuSide = menuSide
        
        if let window = UIApplication.shared.keyWindow {
            window.addSubview(blackView)
            window.addSubview(collectionView)
            blackView.frame = window.frame
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDissmiss)))
            blackView.alpha = 0
            self.collectionView.alpha = 1
            self.collectionView.backgroundColor = menuBackColor

            print(menuSide)
            
            let menuLoc = slideMenuLocationCalculator(window: window)
            
            print(menuLoc.xFrom , menuLoc.xTo)
            collectionView.frame = CGRect(x: menuLoc.xFrom, y: menuLoc.yFrom, width: menuLoc.width , height: menuLoc.height)
            
            UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                self.collectionView.frame = CGRect(x: menuLoc.xTo, y: menuLoc.yTo, width: menuLoc.width, height: menuLoc.height)
            }, completion: nil)
            
        }
    }
    
    
    func slideMenuLocationCalculator(window: UIView) -> MenuLocation {
        var menuLocation = MenuLocation()
        
        let menuHeight:CGFloat = ( CGFloat(settings.count) + 1 ) * menuCellheight
        let menuWidth:CGFloat = menuCellWidth // + menuIconsSize + 32

        switch MainMenuSide {
        case .TOP :
            menuLocation.width = window.frame.width
            menuLocation.height = menuHeight // mainMenuSize!
            menuLocation.xTo = 0
            menuLocation.yTo = 0
            menuLocation.xFrom = 0
            menuLocation.yFrom = 0 - menuHeight // - mainMenuSize!
        case .Right :
            menuLocation.width = menuWidth //mainMenuSize!
            menuLocation.height = window.frame.height
            menuLocation.xTo = window.frame.width - menuLocation.width
            menuLocation.yTo = 0
            menuLocation.xFrom = window.frame.width
            menuLocation.yFrom = 0
        case .Left :
            menuLocation.width = menuWidth //mainMenuSize!
            menuLocation.height = window.frame.height
            menuLocation.xTo = 0
            menuLocation.yTo = 0
            menuLocation.xFrom = 0 - menuWidth //mainMenuSize!
            menuLocation.yFrom = 0
        case .Bottom :
            menuLocation.width = window.frame.width
            menuLocation.height = menuHeight //mainMenuSize!
            menuLocation.xTo = 0
            menuLocation.yTo = window.frame.height - menuLocation.height
            menuLocation.xFrom = 0
            menuLocation.yFrom = window.frame.height
            break
//        default :
//            menuLocation.width = window.frame.width
//            menuLocation.height = menuHeight //mainMenuSize!
//            menuLocation.xTo = 0
//            menuLocation.yTo = window.frame.height - menuLocation.height
//            menuLocation.xFrom = 0
//            menuLocation.yFrom = window.frame.height
//            break
        }
        
        return menuLocation
    }
    
    @objc func handleDissmiss() {
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                let menuLoc = self.slideMenuLocationCalculator(window: window)
                self.collectionView.frame = CGRect(x: menuLoc.xFrom, y: menuLoc.yFrom,  width: menuLoc.width, height: menuLoc.height)
            }
            self.collectionView.alpha = 0
            //self.collectionView.frame = CGRect(x: xFrom, y: yFrom, width: width, height: height)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingCell
        
        let setting = settings[indexPath.item]
        cell.setting = setting
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: menuCellheight)
//        return CGSize(width: menuCellWidth , height: menuCellheight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let setting = settings[indexPath.item]
        print(setting.name)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                let menuLoc = self.slideMenuLocationCalculator(window: window)
                self.collectionView.frame = CGRect(x: menuLoc.xFrom, y: menuLoc.yFrom,  width: menuLoc.width, height: menuLoc.height)
            }
            self.collectionView.alpha = 0
        }) { (completed: Bool) in
            self.selectionDelegate.didTapSelect(menuSelection: setting.name, description: "User Taped on \(setting.name)")
        }
    }
    
}

protocol SelectionDelegate {
    func didTapSelect(menuSelection: String, description: String)
}
