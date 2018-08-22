//
//  ViewController.swift
//  ToDoApp
//
//  Created by VALTER ANDRE MACHADO on 08/08/2018.
//  Copyright © 2018 VALTER ANDRE MACHADO. All rights reserved.
//

import UIKit

class ToDoListVC: UITableViewController {

    let itemArray = ["PE Class", "Get Hamburger", "Clean Up the House "]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //MARK: TableView DataSource
    
    // numberOfRows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    // cellForRow
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    //MARK: TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(indexPath.row)
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
           tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else
        {
           tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
   


}

