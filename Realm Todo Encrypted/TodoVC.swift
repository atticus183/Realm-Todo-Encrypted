//
//  ViewController.swift
//  Realm Todo Encrypted
//
//  Created by Josh R on 1/21/19.
//  Copyright © 2019 Josh R. All rights reserved.
//

import UIKit
import RealmSwift

class TodoVC: UIViewController {
    
    var realm: Realm?
    var todos: Results<Todo>?
    private var todoToken: NotificationToken?
    
    let cellID = "todoCell"
    
    @IBOutlet weak var tableView: UITableView!
    @IBAction func addTodoBtnAction(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "toAddTodoVC", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        realm = MyRealmConfiguration.getRealm()
        todos = realm?.objects(Todo.self).sorted(byKeyPath: "dateEntered", ascending: true)
        
        //removes empty cells in the tableview
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //MARK: Observer
        todoToken = todos?.observe { [weak tableView] changes in
            guard let tableView = tableView else { return }
            switch changes {
            case .initial:
                tableView.reloadData()
            case .update(_, let deletions, let insertions, let updates):
                tableView.applyChanges(deletions: deletions, insertions: insertions, updates: updates)
            case .error: break
            }
        }
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        todoToken?.invalidate()
    }


}


extension TodoVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        guard let todo = todos?[indexPath.row] else { return UITableViewCell() }
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "MMMM dd, yyyy HH:mm"
        
        cell.textLabel?.text = todo.name
        cell.detailTextLabel?.text = dateFormatter.string(from: todo.dateEntered)
        cell.accessoryType = todo.isCompleted ? .checkmark : .none
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let todo = todos?[indexPath.row] else { return }
        
        try! realm?.write {
            todo.isCompleted.toggle()
        }
    }
    
    
    //MARK: Delete function
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            guard let todo = todos?[indexPath.row] else { return }
            guard let realm = realm else { return }
            
            try! realm.write {
                realm.delete(todo)
            }
        }
    }
    
    
}
