//
//  ConcentratePickPack.swift
//  TruthOrDare
//
//  Created by Alexey on 13.08.2020.
//  Copyright © 2020 Alexey. All rights reserved.
//

import Foundation
import UIKit
protocol needsReload {
    func reloadCollectionViewPlease()
}
class ConcentrateAPIPickPack: NSObject, UICollectionViewDataSource{
    var packsHub = Packs(packs: [Pack.init(id: -1, title: "", levelAction: "1488", levelTruth: "228")])
    var delegate: needsReload?
    var dataSourse: PacksManager = APITruthOrDare() as PacksManager
    var isLocal = false
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return packsHub.packs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let packCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PackCollectionViewCell
        packCell.title.text = packsHub.packs[indexPath.row].title
        packCell.level.text = packsHub.packs[indexPath.row].levelTruth
        return packCell
    }
    func changeDataSourse(){
        isLocal.toggle()
        if isLocal{
            dataSourse = APIDatabase()
        } else {
            dataSourse = APITruthOrDare()
        }
        
        getAllPacks()
    }

    func getAllPacks(){
        dataSourse.getAllPacks(completionBlock: {(packs) in
                self.packsHub = packs
                self.delegate!.reloadCollectionViewPlease()
            })
        
            
        
    }
    
    public func getIdByIndexPath(_ ind: Int) -> Int{
        return packsHub.packs[ind].id
    }
    
    override init() {
        super.init()
        getAllPacks()
    }
   
}
struct Pack: Codable{
    var id: Int
    var title: String
    var levelAction: String
    var levelTruth: String
}
struct Packs: Codable{
    var packs: [Pack]
}

struct Task: Codable{
    var levelOfHard: String
    var content: String
    var isTruth: Int
}
struct Tasks: Codable {
    var pack: [Task]
}
