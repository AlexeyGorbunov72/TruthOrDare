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
        vc.delegate = concentrate.self
        self.present(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView,
    willDisplay cell: UICollectionViewCell,
    forItemAt indexPath: IndexPath){
        concentrate.animatePlease(indexPath, cell: cell)
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
   
    
    
    @IBOutlet weak var addPackButton: UIBarButtonItem!
    
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    @IBAction func pressAddPackButton(_ sender: UIBarButtonItem) {
        let altAddPack = UIAlertController(title: "осталось только придумать название!", message: "Залить твой пак на сервер?", preferredStyle: UIAlertController.Style.alert)
        altAddPack.addAction(UIAlertAction(title: "Давай", style: UIAlertAction.Style.default){ _ in
            self.concentrate.savePack(isLocal: false)
        })
        altAddPack.addAction(UIAlertAction(title: "Не, спасибо", style: UIAlertAction.Style.default){ [unowned self] _ in
            self.concentrate.savePack(isLocal: true)
        })
        altAddPack.addTextField(configurationHandler: concentrate.handleTextField)
        self.present(altAddPack, animated: true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        plusButton.setImage(UIImage(systemName: "plus")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        plusButton.layer.cornerRadius = plusButton.frame.height / 2
        plusButton.layer.shadowOpacity = 0.7
        plusButton.layer.shadowRadius = 5
        concentrate.delegate = self
        myCollectionView.delegate = self
        myCollectionView.dataSource = concentrate
        
        
    }
    
}



extension AddPackViewController: GetCollectionView{
    func getCollectionView() -> UICollectionView {
        return myCollectionView
    }
    
    
}
