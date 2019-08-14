//
//  BloggerTableViewController.swift
//  BloggerAPICORE
//
//  Created by IMCS2 on 8/6/19.
//  Copyright © 2019 Tanishk. All rights reserved.
//
import UIKit
import CoreData


class BloggerTableViewController: UITableViewController {
    
    var titleArray1: [String] = []
    var blog = [NSManagedObject]()
    var savedDataArray: [String] = []
    var savedUrlArray: [String] = []
    
    
  
    
    var titleArray: [String] = []
    var urlArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        let url = URL(string: "https://www.googleapis.com/blogger/v3/blogs/2399953/posts?key=AIzaSyAPDaDuIRsJJwn97ZpHQUfndg9wETzKSL0")
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error == nil {
                if let unwrappedData = data {
                    do {
                        let jsonResult = try JSONSerialization.jsonObject(with: unwrappedData, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                        // print((jsonResult)!)
                        
                        //   print(jsonResult!["name"]!)
                        
                        let weather = jsonResult?["items"] as? NSArray
                        DispatchQueue.main.async {
                        if let count = weather?.count {
                            for i in 0...count-1 {
                                let getArray = weather?[i] as? NSDictionary
                                self.titleArray.append(getArray!["title"] as! String)
                               // self.getArray(sender: self.titleArray)
                                self.urlArray.append(getArray!["url"] as! String)
                                
                            
                        }
                        }
                        
                            //callig to save the array
                            self.save(titleArraySave: self.titleArray, urlArraySave: self.urlArray)
                         self.tableView.reloadData()
                          
                            
                        }
                       
                        
                        
                        
//                        print(self.titleArray)
//                        print(self.urlArray)
                        
                        
                        
                        
                    }catch {
                        print("error in fetching")
                    }
                    
                }
            }
        }
        task.resume()
        
        
        
        fetchFromCoreData()
        
        
    }
    
//    func getArray(sender: [String])  {
//
//        titleArray1 = sender
//      //  tableView.reloadData()
//       // self.save(titleArraySave: titleArray1)
//       // print(titleArray1)
////        fetchFromCoreData()
//
//    }
//
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // using the saved data to retrieve no of rows
        return savedDataArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = String(savedDataArray[indexPath.row])
        
        
       
        return cell
    }
    
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    func save(titleArraySave: [String], urlArraySave: [String] ) {
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: "Blog",
                                       in: managedContext)!
        
        let blogdata = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        // 3
        blogdata.setValue(titleArraySave, forKeyPath: "title")
        blogdata.setValue(urlArraySave, forKeyPath: "url")
       // person.setValue(age, forKeyPath: "age")
        // 4
        do {
            try managedContext.save()
            blog.append(blogdata)
            print(blog)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    func fetchFromCoreData() {

        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }

        let managedContext =
            appDelegate.persistentContainer.viewContext

        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Blog")
        
        //3
        do {
            blog = try managedContext.fetch(fetchRequest)
            for blogs in blog{
                //adding values to the saved data array
                savedDataArray = (blogs.value(forKeyPath: "title") as? [String])!
                savedUrlArray = (blogs.value(forKeyPath: "url") as? [String])!
               // let age = person.value(forKeyPath: "age") as? Int
                

            }
            print("this is saved \(savedDataArray)")

        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }

    }
    
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    let blogSegueIdentifier = "showSegue"

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if  segue.identifier == blogSegueIdentifier,
            let destination = segue.destination as? ViewController,
            let blogIndex = tableView.indexPathForSelectedRow?.row
        {
            //print("this is titleArray1 \(titleArray1[blogIndex])")
            destination.blogName = savedDataArray[blogIndex]
            destination.trueUrl = savedUrlArray[blogIndex]
            
        }
        
    }

}
