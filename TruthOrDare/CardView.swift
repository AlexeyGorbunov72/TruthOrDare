//
//  CardView.swift
//  TruthOrDare
//
//  Created by Alexey on 15.08.2020.
//  Copyright © 2020 Alexey. All rights reserved.
//

import Foundation
import UIKit

class CardView: UIView{
    var task: Task?{
        get{
            return nil
        }
        set{
            if let task = newValue{
                if(task.isTruth == 1){
                    emojiLabel.text = "🤫"
                } else {
                    emojiLabel.text = "🤼‍♀️"
                }
                contentLabel.text = task.content
            }
            
            
        }
    }
    var emojiLabel: UILabel{
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        return label
    }
    var contentLabel: UILabel{
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        return label
    }
    var nextButton: UIButton{
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("дальше", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(pressNext), for: .touchUpInside)
        button.layer.backgroundColor = .init(srgbRed: 0.9, green: 0.9, blue: 0.9, alpha: 0.9)
        button.layer.cornerRadius = button.frame.height / 2
        return button
    }
    @objc func pressNext(){
        print("да да слышу бля нажал ок")
    }
    func setupLayout(){
        self.addSubview(nextButton)
        self.addSubview(emojiLabel)
        self.addSubview(contentLabel)
        
        NSLayoutConstraint.activate([
            nextButton.bottomAnchor.constraint(equalTo: self.topAnchor, constant: -20),
            nextButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            nextButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            contentLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            contentLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            contentLabel.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: 20),
            
            
            emojiLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            emojiLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            emojiLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            emojiLabel.bottomAnchor.constraint(equalTo: contentLabel.topAnchor, constant: 20)
        ])
 
    }
    override init(frame: CGRect) {
      super.init(frame: frame)
      setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      setupLayout()
    }
}
