//
//  CategoryViewController.swift
//  Todoey
//
//  Created by José María Aguíñiga Díaz on 17/07/18.
//  Copyright © 2018 José María Aguíñiga Díaz. All rights reserved.
//

import UIKit

import RealmSwift

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var categoryArray : Results<Category>!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadItems()
    }
    
    //MARK - Tableview datasource methods
    //For displaying categories
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        
        
        cell.textLabel?.text = categoryArray?[indexPath.row].Name ?? "No categories added yet"
        
        //cell.accessoryType = category.status ? .checkmark : .none
        
        return cell
    }
    
    
    
    //MARK - Data manipulation methods
    //For saving and loading data, CRUD
    
    func save(category : Category){
        
        do{
            try realm.write {
                realm.add(category)
            }
        }catch{
            
            print("Error trying to save data \(error)")
            
        }
        
        self.tableView.reloadData()
        
    }
    
    
    func loadItems(){
       categoryArray = realm.objects(Category.self)
        
        tableView.reloadData()
    }
    
    
    
    
    

    //MARK - Add new categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var newTextField = UITextField()
        
        let alert = UIAlertController(title: "Add a new category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add category", style: .default) { (action) in
            
            let newCategory = Category()
            
            newCategory.Name = newTextField.text!
            
      
            
            self.save(category: newCategory)
            
            
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
            destinationVC.selectedCategory = categoryArray?[indexPath.row]
        }
    }
    
}
