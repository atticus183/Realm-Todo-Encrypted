//
//  AddTodoVC.swift
//  Realm Todo Encrypted
//
//  Created by Josh R on 1/21/19.
//  Copyright © 2019 Josh R. All rights reserved.
//

import UIKit
import RealmSwift

class AddTodoVC: UIViewController {
    
    var realm: Realm?
    
    @IBOutlet weak var todoTxtField: UITextField!
    
    @IBAction func addTodoBtn(_ sender: AddTodoBtn) {
        guard let realm = realm else { return }
        try! realm.write {
            let todo = Todo()
            todo.name = todoTxtField.text!
            todo.isCompleted = false
            todo.dateEntered = Date()
            
            realm.add(todo)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        realm = MyRealmConfiguration.getRealm()
    }
    

}
