//
//  PickPackViewController.swift
//  TruthOrDare
//
//  Created by Alexey on 13.08.2020.
//  Copyright © 2020 Alexey. All rights reserved.
//

import UIKit

class PickPackViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var segmented: UISegmentedControl!
    @IBAction func segmentedDidChange(_ sender: Any) {
        
        concentrate.changeDataSourse()
    }
    fileprivate let myCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionv.translatesAutoresizingMaskIntoConstraints = false
        collectionv.register(PackCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionv.showsVerticalScrollIndicator = false
        return collectionv
    }()
    private let concentrate = ConcentrateAPIPickPack()
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: myCollectionView.frame.width/1.5,height: myCollectionView.frame.height/2)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        concentrate.dataSourse.getPackContent(concentrate.getIdByIndexPath(indexPath.row)) { [unowned self] (tasks) in
                DispatchQueue.main.async {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
                    vc.modalPresentationStyle = .fullScreen
                    vc.tasks = tasks
                    
                    self.present(vc, animated: true)
                    
                }
                
            }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        concentrate.delegate = self
        myCollectionView.backgroundColor = .white
        myCollectionView.delegate = self
        myCollectionView.dataSource = concentrate
        myCollectionView.contentInset = UIEdgeInsets(top: 15, left: 0, bottom: 10, right: 0);
        view.addSubview(myCollectionView)
        
        let margins = view.layoutMarginsGuide
         NSLayoutConstraint.activate([
           myCollectionView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
           myCollectionView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
           myCollectionView.topAnchor.constraint(equalTo: margins.topAnchor),
           myCollectionView.bottomAnchor.constraint(equalTo: margins.bottomAnchor)])
        
        
    }

}
extension PickPackViewController: needsReload{
    func reloadCollectionViewPlease() {
        DispatchQueue.main.async {
            self.myCollectionView.reloadData()
        }
    }
}
