//
//  addPackConcentrate.swift
//  TruthOrDare
//
//  Created by Alexey on 21.08.2020.
//  Copyright © 2020 Alexey. All rights reserved.
//

import UIKit
protocol getCell: needsReload{
    func getCell(indexPath: IndexPath) -> UICollectionViewCell
    func reloadCollectionViewPlease()
}

class addPackConcentrate: NSObject, UICollectionViewDataSource{
    lazy var data: Tasks = {
        let tasks = Tasks(pack: [Task(levelOfHard: "10", content: "jdadoajshdoiahdoiahdoia", isTruth: 0), Task(levelOfHard: "0.323", content: "qdqwdwqdqw", isTruth: 1)])
        return tasks
    }()
    var delegate: getCell?
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.pack.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! addPackCollectionViewCell
        cell.data = data.pack[indexPath.row]
        return cell
    }
    
    
    
    
}
