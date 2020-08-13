//
//  PickPackViewController.swift
//  TruthOrDare
//
//  Created by Alexey on 13.08.2020.
//  Copyright © 2020 Alexey. All rights reserved.
//

import UIKit

class PickPackViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    fileprivate let myCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionv.translatesAutoresizingMaskIntoConstraints = false
        collectionv.register(PackCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionv
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let packCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PackCollectionViewCell
        packCell.title.text = "стандартный"
        packCell.level.text = "102/132"
        return packCell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: myCollectionView.frame.width/1.5,height: myCollectionView.frame.height/2)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myCollectionView.backgroundColor = .white
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        view.addSubview(myCollectionView)
        let margins = view.layoutMarginsGuide
         NSLayoutConstraint.activate([
           myCollectionView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
           myCollectionView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
           myCollectionView.topAnchor.constraint(equalTo: margins.topAnchor),
           myCollectionView.bottomAnchor.constraint(equalTo: margins.bottomAnchor)])
        
        
 
    }

}
