//
//  ViewController.swift
//  Realm Todo Encrypted
//
//  Created by Josh R on 1/21/19.
//  Copyright © 2019 Josh R. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    let cellID = "todoCell"
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }


}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
