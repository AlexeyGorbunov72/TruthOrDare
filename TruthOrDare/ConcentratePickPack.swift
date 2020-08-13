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
    private let url = "http://192.168.0.12:8000/api/getPacks"
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return packsHub.packs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let packCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PackCollectionViewCell
        packCell.title.text = packsHub.packs[indexPath.row].title
        packCell.level.text = packsHub.packs[indexPath.row].levelTruth
        return packCell
    }
    func getAllPacks(){
        
        if let url = URL(string: url){
            URLSession.shared.dataTask(with: url){data, res, err in
                if let data = data{
                    let decoder = JSONDecoder()
                    if let json = try? decoder.decode(Packs.self, from: data){

                        self.packsHub = json
                        self.delegate!.reloadCollectionViewPlease()
                    }
                    
                    
                }
            }.resume()
        }
    }
    override init() {
        super.init()
        getAllPacks()
    }
   
}
struct Pack: Decodable{
    var id: Int
    var title: String
    var levelAction: String
    var levelTruth: String
}
struct Packs: Decodable{
    var packs: [Pack]
}
