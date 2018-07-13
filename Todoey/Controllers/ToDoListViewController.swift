//
//  ViewController.swift
//  Todoey
//
//  Created by José María Aguíñiga Díaz on 13/07/18.
//  Copyright © 2018 José María Aguíñiga Díaz. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemArray = [ItemStatus]()
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = ItemStatus()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        let newItem2 = ItemStatus()
        newItem2.title = "Find Marcela"
        itemArray.append(newItem2)
        
        let newItem3 = ItemStatus()
        newItem3.title = "Find Gaby"
        itemArray.append(newItem3)
        
        // Do any additional setup after loading the view, typically from a nib.
        
        if let items = UserDefaults.standard.array(forKey: "ToDoListArray") as? [ItemStatus] {
            itemArray = items
        }
        
 
    }

    //MARK - Tableview Datasource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        //Ternary operator
        // value = condition ? valueIfTrue : valueIfFalse
        
        cell.accessoryType = item.status ? .checkmark : .none
        
        
        
        return cell
        
    }
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].status = !itemArray[indexPath.row].status
        
       
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    //MARK - Add new items sections
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
       var textFieldNew = UITextField()
        
        let alert = UIAlertController(title: "Add new todoey action", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            //What will happen once the user clicks the add item button on our UIAlert
            
            let newItem = ItemStatus()
            
            newItem.title = textFieldNew.text!
            
            self.itemArray.append(newItem)
            
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

