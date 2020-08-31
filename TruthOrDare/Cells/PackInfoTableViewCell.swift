//
//  PackInfoTableViewCell.swift
//  TruthOrDare
//
//  Created by Alexey on 14.08.2020.
//  Copyright © 2020 Alexey. All rights reserved.
//

import UIKit

class PackInfoTableViewCell: UITableViewCell {
    let contentLabel = UILabel()
    let markLabel = UILabel()
    var contentOfTask: Task? {
        set(task){
            if let task = task{
                if(task.isTruth == 1){
                    markLabel.text = "🤫"
                } else {
                    markLabel.text = "🤼‍♀️"
                }
                contentLabel.text = task.content
                setup()
                }
              
               
            }
        
        get{
            return self.contentOfTask
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
   
    func setup(){
        
        contentView.backgroundColor = .systemIndigo
        contentView.layer.cornerRadius = 20
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        markLabel.translatesAutoresizingMaskIntoConstraints = false
        markLabel.numberOfLines = 0
        contentLabel.numberOfLines = 0
        contentLabel.textColor = .white
        contentView.addSubview(markLabel)
        contentView.addSubview(contentLabel)
        NSLayoutConstraint.activate([
            contentLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            contentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            contentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            contentLabel.leadingAnchor.constraint(equalTo: markLabel.trailingAnchor, constant: 20),
            markLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            markLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
        ])
        
    }
   /* func setupLabels(_ task: Task){
        let content = UILabel()
        let hardLevel = UILabel()
        content.numberOfLines = 0
        hardLevel.numberOfLines = 0
        content.font = .boldSystemFont(ofSize: 30)
        content.text = task.content
        hardLevel.text = task.levelOfHard
        
        content.translatesAutoresizingMaskIntoConstraints = false
        hardLevel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(content)
       // contentView.addSubview(hardLevel)
        NSLayoutConstraint.activate(
            [content.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
             content.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
             content.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 20),
             content.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 20)])
          //   hardLevel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
          //   hardLevel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
          //   hardLevel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 20),]
        
        //content.trailingAnchor.constraint(equalTo: hardLevel.leadingAnchor, constant: -20).isActive = true
    }
 */
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
