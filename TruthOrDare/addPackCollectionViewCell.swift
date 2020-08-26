//
//  addPackConcentrate.swift
//  TruthOrDare
//
//  Created by Alexey on 18.08.2020.
//  Copyright © 2020 Alexey. All rights reserved.
//

import Foundation
import UIKit
class addPackCollectionViewCell: UICollectionViewCell{
    
    var data: Task{
        set(task){
            contentView.layer.shadowRadius = 5
            contentView.layer.shadowOpacity = 0.5
            contentView.layer.shadowOffset = CGSize(width: 10, height: 10)
            
            contentLabel?.text = task.content
            if(task.isTruth == 1){
                typeButton?.titleLabel?.text = "🤫"
            } else{
                typeButton?.titleLabel?.text = "🤼‍♀️"
            }
        }
        get{
            return data
        }
    }
    @IBOutlet weak var sliderOutlet: UISlider?
    @IBOutlet weak var typeButton: UIButton?
    @IBOutlet weak var contentLabel: UILabel?
    
    @IBAction func sliderPicker(_ sender: Any) {
        if let sender = sender as? UISlider{
            print(sender.value)
        }
       
    }
    @IBOutlet weak var leftEmoji: UILabel?
    @IBOutlet weak var rightEmoji: UILabel?
    
    
}
