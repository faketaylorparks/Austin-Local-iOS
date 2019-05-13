//
//  DetailViewController.swift
//  final
//
//  Created by taylor parks on 5/6/19.
//  Copyright © 2019 taylor parks. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var subject: UILabel!
    
    @IBOutlet weak var message: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subject.text = postData[selection]["subject"]
        message.text = postData[selection]["body"]
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
