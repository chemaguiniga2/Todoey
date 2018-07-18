//
//  CategoryViewController.swift
//  Todoey
//
//  Created by José María Aguíñiga Díaz on 17/07/18.
//  Copyright © 2018 José María Aguíñiga Díaz. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categoryArray = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadItems()
    }
    
    //MARK - Tableview datasource methods
    //For displaying categories
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let category = categoryArray[indexPath.row]
        
        cell.textLabel?.text = category.title
        
        //cell.accessoryType = category.status ? .checkmark : .none
        
        return cell
    }
    
    
    
    //MARK - Data manipulation methods
    //For saving and loading data, CRUD
    
    func saveItems(){
        
        do{
            try context.save()
        }catch{
            
            print("Error trying to save data \(error)")
            
        }
        
        self.tableView.reloadData()
        
    }
    
    
    func loadItems(with request : NSFetchRequest<Category> = Category.fetchRequest()){
        //let request : NSFetchRequest<ItemStatus> = ItemStatus.fetchRequest()
        
        
        do{
            
            categoryArray = try context.fetch(request)
        }catch{
            print("Error fetching data \(error)")
        }
        
        tableView.reloadData()
    }
    
    
    
    
    

    //MARK - Add new categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var newTextField = UITextField()
        
        let alert = UIAlertController(title: "Add a new category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add category", style: .default) { (action) in
            
            let newCategory = Category(context: self.context)
            
            newCategory.title = newTextField.text!
            
            self.categoryArray.append(newCategory)
            
            self.saveItems()
            
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add new category"
            
            newTextField = alertTextField
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
        
    }
    
    
    
    
    //MARK - Tableview delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
    }
    
}
