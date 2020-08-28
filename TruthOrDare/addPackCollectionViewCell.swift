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
    var idOfCell: Int?
    @IBOutlet weak var sliderOutlet: UISlider?
    @IBOutlet weak var typeButton: UIButton?
    @IBOutlet weak var contentLabel: UILabel?
    @IBOutlet weak var leftEmoji: UILabel?
    @IBOutlet weak var rightEmoji: UILabel?
    
    
    var data: Task{
        set(task){
            contentView.layer.shadowRadius = 5
            contentView.layer.shadowOpacity = 0.5
            contentView.layer.shadowOffset = CGSize(width: 10, height: 10)
            animateSlider(value: task.levelOfHard)
            contentLabel?.text = task.content
            if(task.isTruth == 1){
                typeButton?.setTitle("🤫", for: .normal)
             
            } else{
                typeButton?.setTitle("🤼‍♀️", for: .normal)
                
            }
        }
        get{
            return self.data
        }
    }
    func animateSlider(value: String){
        sliderOutlet?.setValue(0, animated:false)
        let newValue = Float(value)
        UIView.animate(withDuration: 0.75, delay: 0, options: [.curveEaseOut], animations: {
            self.sliderOutlet?.setValue(newValue!, animated:true)
        })
    }
    @IBAction func sliderPicker(_ sender: Any) {
        if let sender = sender as? UISlider{
            NotificationCenter.default
            .post(name:           NSNotification.Name("addPack.cell.slider.didChangeValue"),
             object: nil,
             userInfo: ["id": idOfCell, "value": sender.value])
        }
       
    }
    
    
}
