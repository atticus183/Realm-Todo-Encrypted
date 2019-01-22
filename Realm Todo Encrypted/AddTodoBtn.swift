//
//  AddTodoBtn.swift
//  Realm Todo Encrypted
//
//  Created by Josh R on 1/21/19.
//  Copyright © 2019 Josh R. All rights reserved.
//

import UIKit

class AddTodoBtn: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func prepareForInterfaceBuilder() {
        setup()
    }
    
    private func setup() {
        self.frame = CGRect(x: 0, y: 0, width: 150, height: 50)
//        self.backgroundColor = greenCheckMarkBtnColor
        self.titleLabel!.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        self.setTitleColor(.white, for: .normal)
        self.setTitle("ADD", for: .normal)
        self.titleLabel?.textAlignment = .center
        self.layer.cornerRadius = self.layer.frame.height / 2
        self.layer.masksToBounds = true
    }

}
