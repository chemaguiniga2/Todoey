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
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
        loadItems()
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
        
        saveItems()
        
        
        
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
            
           self.saveItems()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create a new item"
        
            textFieldNew = alertTextField
            
        }
        
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func saveItems(){
        
        let encoder = PropertyListEncoder()
        
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        }catch{
            print("Error encoding item away \(error)")
        }
        
        
        self.tableView.reloadData()
        
        
    }
    
    func loadItems(){
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
               itemArray = try decoder.decode([ItemStatus].self, from: data)
            }catch{
                print("Error decoding \(error)")
            }
        }
    }
    


}

