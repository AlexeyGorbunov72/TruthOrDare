//
//  PackInfoViewController.swift
//  TruthOrDare
//
//  Created by Alexey on 14.08.2020.
//  Copyright © 2020 Alexey. All rights reserved.
//

import UIKit

class PackInfoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    @IBOutlet weak var tasksTableView: UITableView!
    var dataTask: Tasks?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return dataTask?.pack.count ?? 12
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PackInfoTableViewCell
        cell.contentOfTask = dataTask?.pack[indexPath.row]
        
        return cell
     }
     
     
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
        return UITableView.automaticDimension
    
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tasksTableView.dataSource = self
        tasksTableView.delegate = self
        tasksTableView.register(PackInfoTableViewCell.self, forCellReuseIdentifier: "cell")
    }
}
