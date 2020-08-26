//
//  AddPackViewController.swift
//  TruthOrDare
//
//  Created by Alexey on 17.08.2020.
//  Copyright © 2020 Alexey. All rights reserved.
//

import UIKit

class AddPackViewController: UIViewController, UICollectionViewDelegate{
    @IBAction func pressAddButton(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "addTask") as! AddTaskViewController
        self.present(vc, animated: true)
    }
    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout! {
        didSet {
            collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        return layout
    }()
    let concentrate = addPackConcentrate()
   
    
    
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    let data = Tasks(pack: [Task(levelOfHard: "123", content: "ajdbajskdb asjkdb", isTruth: 1), Task(levelOfHard: "123", content: "ajdbajwfoewfh ioehfjskdb asjkdb", isTruth: 0)])
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        concentrate.data = data
        concentrate.delegate = self
        
        myCollectionView.delegate = self
        myCollectionView.dataSource = concentrate
        setupMyViewController()
        
    }
    
}

extension AddPackViewController: getCell{
    func reloadCollectionViewPlease() {
        DispatchQueue.main.async {
            self.myCollectionView.reloadData()
        }
    }
    func getCell(indexPath: IndexPath) -> UICollectionViewCell{
        let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! addPackCollectionViewCell
        return cell
    }
}
extension AddPackViewController: UICollectionViewDelegateFlowLayout{
    
    func setupMyViewController(){

    }
}

