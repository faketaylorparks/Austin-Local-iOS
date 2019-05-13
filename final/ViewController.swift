//
//  ViewController.swift
//  final
//
//  Created by taylor parks on 5/4/19.
//  Copyright © 2019 taylor parks. All rights reserved.
//

import UIKit
import FirebaseDatabase
var selection:Int = 0
var postData = [[String: String]]()

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
var newsItems = [String]()
    var ref:DatabaseReference?
    var databaseHandle:DatabaseHandle?
    
    @IBOutlet weak var headlines: UILabel!

    @IBOutlet weak var theNews: UITableView!

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
        cell?.textLabel?.text = (postData[indexPath.row]["subject"] as! String)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selection = indexPath.row
        performSegue(withIdentifier: "TheSegue", sender: self)
    }
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        theNews.delegate = self
        theNews.dataSource = self
        ref=Database.database().reference()
        databaseHandle = ref?.child("Posts").observe(.childAdded, with: { (snapshot) in
            let post = snapshot.value
            postData.append(post as! [String : String])
            self.theNews.reloadData()
        })
        
    }            // Do any additional setup after loading the view.
    }
