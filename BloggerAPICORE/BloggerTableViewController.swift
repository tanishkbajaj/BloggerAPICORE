//
//  BloggerTableViewController.swift
//  BloggerAPICORE
//
//  Created by IMCS2 on 8/6/19.
//  Copyright © 2019 Tanishk. All rights reserved.
//

import UIKit

class BloggerTableViewController: UITableViewController {
    
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
                        if let count = weather?.count {
                        for i in 0...count-1 {
                            let getArray = weather?[i] as? NSDictionary
                            self.titleArray.append(getArray!["title"] as! String)
                            self.urlArray.append(getArray!["url"] as! String)
                            
                        }
                        }
                        //  print(weather)
                        
                        
                        
                        
                        print(self.titleArray)
                        print(self.urlArray)
                        
                        
                        
                        
                    }catch {
                        print("error in fetching")
                    }
                    
                }
            }
        }
        task.resume()
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = String(indexPath.row)
        // Configure the cell...
        
        return cell
    }
    
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
