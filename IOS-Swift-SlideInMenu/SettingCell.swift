//
//  SettingCell.swift
//  IOS-Swift-SlideInMenu
//
//  Created by Pooya on 2018-06-26.
//  Copyright © 2018 Pooya. All rights reserved.
//

import UIKit

class Setting: NSObject {
    let name:String
    let imageName:String
    
    init(name: String, imageName:String) {
        self.name = name
        self.imageName = imageName
    }
}

class SettingCell: BaseCell {
    
    var localslideInHandler = SlideInHandler()

    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ?  UIColor.darkGray : UIColor.clear
            nameLabel.textColor = isHighlighted ? UIColor.white : UIColor.black
            //iconImageView.tintColor = isHighlighted ? UIColor.white : UIColor.darkGray
            //print(isHighlighted)
        }
    }
    
    var setting: Setting? {
        didSet {
            nameLabel.text = setting?.name
            iconImageView.image = UIImage(named: (setting?.imageName ?? "?"))
//            iconImageView.image = UIImage(named: (setting?.imageName ?? "?"))?.withRenderingMode(.alwaysTemplate)
        }
    }
    
    let nameLabel:UILabel = {
        let label = UILabel()
        label.text = "Not Set yet?"
        label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.subheadline)  //UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    let iconImageView:UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "?")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func setupViews() {
        super.setupViews()
        
        backgroundColor = localslideInHandler.menuCellsBackColor //UIColor.blue
        addSubview(nameLabel)
        addSubview(iconImageView)
        
        addConstraintsWithFormat("H:|-8-[v0(30)]-8-[v1]", views: iconImageView,nameLabel)
        addConstraintsWithFormat("V:|[v0]|", views: nameLabel)
        addConstraintsWithFormat("V:[v0(30)]", views: iconImageView)
        
        addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
//        //build dinctionary of views
//        let viewsDict = ["labelName": labelName,
//                         "iconImage": iconImage];
//
//
//        let menuHorizontal = NSLayoutConstraint.constraints(
//            withVisualFormat: "H:|[labelName]|",
//            options: [], metrics: nil, views: viewsDict)
//        let menuVertical = NSLayoutConstraint.constraints(
//            withVisualFormat: "V:|[labelName]|",
//            options: [], metrics: nil, views: viewsDict)
//        addConstraints(menuHorizontal)
//        addConstraints(menuVertical)
        
    }
}




class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
    }
}


enum MenuLocationOption {
    case TOP,Bottom,Right,Left
}
