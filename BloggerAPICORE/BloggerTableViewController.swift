//
//  BloggerTableViewController.swift
//  BloggerAPICORE
//
//  Created by IMCS2 on 8/6/19.
//  Copyright © 2019 Tanishk. All rights reserved.
//

import UIKit


class BloggerTableViewController: UITableViewController {
    
    //var titleArray: [String] = []
    var titleArray1: [String] = []
   // var titleArray: [String] = []
    
    var s = model()

    override func viewDidLoad() {
        super.viewDidLoad()
  
        // Uncomment the following line to preserve selection between presentations
        //  .clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //  .navigationItem.rightBarButtonItem =  editButtonItem
        
        
        fetching()
        
        
        
    }
    
    
    func fetching(){
        
        let url = URL(string: "https://www.googleapis.com/blogger/v3/blogs/2399953/posts?key=AIzaSyAPDaDuIRsJJwn97ZpHQUfndg9wETzKSL0")
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            self.tableView.reloadData()
            if error == nil {
                if let unwrappedData = data {
                    do {
                        
                        let jsonResult = try JSONSerialization.jsonObject(with: unwrappedData, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                        // print((jsonResult)!)
//                     self.titleArray.removeAll()
                        //   print(jsonResult!["name"]!)
                        
                        let weather = jsonResult?["items"] as? NSArray
                        //  print(weather)
                        let getArray = weather?[0] as? NSDictionary
                        // print(weather)
                        // print(getArray)
                        
                        //    print(getArray)
                        //1
                        let getDesc = getArray?["title"] as? String
                        // print(getDesc!)
                        self.s.titleArray.append(getDesc!)
                        //self.titleArray.append(getDesc!)
                        
                        let getArray1 = weather?[1] as? NSDictionary
                        //2
                        let getDesc1 = getArray?["title"] as? String
                       // self.titleArray.append(getDesc1!)
                        self.s.titleArray.append(getDesc1!)
                        
                        let getArray2 = weather?[2] as? NSDictionary
                        //3
                        let getDesc2 = getArray?["title"] as? String
                       // self.titleArray.append(getDesc2!)
                        self.s.titleArray.append(getDesc2!)
                        
                        let getArray3 = weather?[3] as? NSDictionary
                        //4
                        let getDesc3 = getArray?["title"] as? String
                      //  self.titleArray.append(getDesc3!)
                        self.s.titleArray.append(getDesc3!)
                        
                        let getArray4 = weather?[4] as? NSDictionary
                        //5
                        let getDesc4 = getArray?["title"] as? String
                       // self.titleArray.append(getDesc4!)
                        self.s.titleArray.append(getDesc4!)
                        
                        let getArray5 = weather?[5] as? NSDictionary
                        //6
                        let getDesc5 = getArray?["title"] as? String
                       // self.titleArray.append(getDesc5!)
                        self.s.titleArray.append(getDesc5!)
                        
                        let getArray6 = weather?[6] as? NSDictionary
                        //7
                        let getDesc6 = getArray?["title"] as? String
                      //  self.titleArray.append(getDesc6!)
                        self.s.titleArray.append(getDesc6!)
                        
                        let getArray7 = weather?[7] as? NSDictionary
                        //8
                        let getDesc7 = getArray?["title"] as? String
                     //   self.titleArray.append(getDesc7!)
                        self.s.titleArray.append(getDesc7!)
                        
                        let getArray8 = weather?[8] as? NSDictionary
                        //9
                        let getDesc8 = getArray?["title"] as? String
                     //   self.titleArray.append(getDesc8!)
                        self.s.titleArray.append(getDesc8!)
                        
                        let getArray9 = weather?[9] as? NSDictionary
                        //10
                        let getDesc9 = getArray?["title"] as? String
                      //  self.titleArray.append(getDesc9!)
                        self.s.titleArray.append(getDesc9!)
                        
                        print(self.s.titleArray)
                      
                        // print( titleArray)
                        
                        
                        
                        
                    }catch {
                        print("error in fetching")
                    }
                    
                }
                
            }
            
            self.getArray(sender: self.s.titleArray)
             self.tableView.reloadData()
        }
        //print(self.titleArray)
        tableView.reloadData()
        task.resume()

        
    }
    
    func getArray(sender: [String]){
        
        
        titleArray1 = sender
        print(titleArray1)
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return titleArray1.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = String(self.titleArray1[indexPath.row])
        
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
