//
//  ViewController.swift
//  ToDoApp
//
//  Created by VALTER ANDRE MACHADO on 08/08/2018.
//  Copyright © 2018 VALTER ANDRE MACHADO. All rights reserved.
//

import UIKit

class ToDoListVC: UITableViewController {

    var itemArray = ["PE Class", "Get Hamburger", "Clean Up the House "]
    
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
    
    
    //MARK: Add new items
    
    @IBAction func addNewItemsPressed(_ sender: Any) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Schedule", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // here is what will happen once the user clicks the Add Item button

            self.itemArray.append(textField.text!)
            self.tableView.reloadData()
        }
        
        alert.addTextField { (addTextField) in
            addTextField.placeholder = "Creat new item"
            textField = addTextField
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    

}

