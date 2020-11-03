//
//  ViewController.swift
//  ToDoApp
//
//  Created by VALTER ANDRE MACHADO on 08/08/2018.
//  Copyright © 2018 VALTER ANDRE MACHADO. All rights reserved.
//

import UIKit

class ToDoListVC: UITableViewController {

    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPersistedData()
    }
    
    private func fetchPersistedData() {
        let testFromDefaults = defaults.object([Item].self, with: "ToDoListArray")

        if let items = testFromDefaults {
            itemArray = items
        }
    }
    
    private func persistData(_ toDoTitle: String?) {
        let newItem = Item()
        guard let title = toDoTitle else { return }
        
        if title != self.itemArray.first?.title {
            newItem.title = title
            self.itemArray.append(newItem)
        } else {
            print("existing Name")
        }
        
        self.defaults.set(object: self.itemArray, forKey:  "ToDoListArray")
    }

    //MARK: TableView DataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        // TERNARY OPERATOR ==>
        // value = condition ? valueIfTrue : valueIfFalse
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    //MARK: TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        print(self.itemArray.first?.done)
        // persist checkmark state
        self.defaults.set(object: self.itemArray, forKey:  "ToDoListArray")
    }
    
    
    //MARK: Add new items (UIAlertController)
    
    @IBAction func addNewItemsPressed(_ sender: Any) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Schedule", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // here is what will happen once the user clicks the Add Item button
            self.persistData(textField.text)
            
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

extension UserDefaults {
    func object<T: Codable>(_ type: T.Type, with key: String, usingDecoder decoder: JSONDecoder = JSONDecoder()) -> T? {
        guard let data = self.value(forKey: key) as? Data else { return nil }
        return try? decoder.decode(type.self, from: data)
    }

    func set<T: Codable>(object: T, forKey key: String, usingEncoder encoder: JSONEncoder = JSONEncoder()) {
        let data = try? encoder.encode(object)
        self.set(data, forKey: key)
    }
}
