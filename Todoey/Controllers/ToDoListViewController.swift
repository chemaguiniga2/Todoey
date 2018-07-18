//
//  ViewController.swift
//  Todoey
//
//  Created by José María Aguíñiga Díaz on 13/07/18.
//  Copyright © 2018 José María Aguíñiga Díaz. All rights reserved.
//

import UIKit
import CoreData

class ToDoListViewController: UITableViewController, UISearchBarDelegate {
    
    var itemArray = [ItemStatus]()
    
    var selectedCategory : Category?{
        didSet{
            loadItems()
        }
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    //let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
        
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
        
        //context.delete(itemArray[indexPath.row])
        //itemArray.remove(at: indexPath.row)
        
        
        
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
            
            
            
            let newItem = ItemStatus(context: self.context)
            
            newItem.title = textFieldNew.text!
            
            newItem.status = false
            
            newItem.parentCategory = self.selectedCategory
            
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
        
        
        
        do{
            try context.save()
        }catch{
            print("Error saving context \(error)")
        }
        
        
        self.tableView.reloadData()
        
        
    }
    
    func loadItems(with request : NSFetchRequest<ItemStatus> = ItemStatus.fetchRequest(), predicate : NSPredicate? = nil){
        //let request : NSFetchRequest<ItemStatus> = ItemStatus.fetchRequest()
        
        let categoryPredicate = NSPredicate(format: "parentCategory.title MATCHES %@", selectedCategory!.title!)
        
        if let additionalPredicate = predicate{
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
            
        }else{
            request.predicate = categoryPredicate
        }
        
       /* let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, predicate])
        
        request.predicate = compoundPredicate*/
        
        do{
            
            itemArray = try context.fetch(request)
        }catch{
            print("Error fetching data \(error)")
        }
        
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<ItemStatus> = ItemStatus.fetchRequest()
        
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        
        loadItems(with: request, predicate: predicate)
        
        
        
 
        //print(searchBar.text!)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0{
            loadItems()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
            
        }
    }
    


}

