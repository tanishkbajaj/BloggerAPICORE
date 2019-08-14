//
//  ViewController.swift
//  BloggerAPICORE
//
//  Created by IMCS2 on 8/6/19.
//  Copyright © 2019 Tanishk. All rights reserved.
//

import UIKit
import WebKit
import Network

class ViewController: UIViewController {
    @IBOutlet weak var WebUrl: WKWebView!
    
    @IBOutlet weak var TitleLabel: UILabel!
    
    let monitor = NWPathMonitor()
    
    var blogName = String()
    var trueUrl = ""
    
   // let http = "http://some.com/example.html"
    
    
    override func viewWillAppear(_ animated: Bool) {
        TitleLabel.text = blogName
        
        
        
    }
    
    
        override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
           // let url = NSURL(string: t)
           let https = "https" + trueUrl.dropFirst(4)
//            print(https)
            
            let url = NSURL(string: https)
            let urlrequest = URLRequest(url: url! as URL)
            WebUrl.load(urlrequest)
            print(trueUrl)
            
            
            monitor.pathUpdateHandler = { path in
                if path.status == .satisfied {
                    print("We're connected!")
                    
                } else {
                    print("No connection.")
                    DispatchQueue.main.async {
                    self.WebUrl.loadHTMLString("<html><body><h1>cannot display the following URL \(https) because you need to connect to internet</h1></body></html>", baseURL: nil)
                    }
                }
                
                print(path.isExpensive)
            }
            
            let queue = DispatchQueue(label: "Monitor")
            monitor.start(queue: queue)

    }


}

