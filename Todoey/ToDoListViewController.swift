//
//  ViewController.swift
//  Todoey
//
//  Created by José María Aguíñiga Díaz on 13/07/18.
//  Copyright © 2018 José María Aguíñiga Díaz. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemArray = ["Find Gaby", "Buy Eggs"]
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let items = UserDefaults.standard.array(forKey: "ToDoListArray") as? [String] {
            itemArray = items
        }
        
        
    }

    //MARK - Tableview Datasource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
        
    }
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    //MARK - Add new items sections
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
       var textFieldNew = UITextField()
        
        let alert = UIAlertController(title: "Add new todoey action", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            //What will happen once the user clicks the add item button on our UIAlert
            
            self.itemArray.append(textFieldNew.text!)
            
            self.tableView.reloadData()
            
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create a new item"
        
            textFieldNew = alertTextField
            
        }
        
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    


}

