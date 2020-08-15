//
//  GameViewController.swift
//  TruthOrDare
//
//  Created by Alexey on 12.08.2020.
//  Copyright © 2020 Alexey. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    
    @IBOutlet weak var chooseView: UIView!
    @IBAction func chooseAction(_ sender: UIButton) {
        viewNewActionTask()
    }
    @IBAction func chooseTruth(_ sender: UIButton) {
        viewNewTruthTask()
    }
    @IBAction func closeGameButton(_ sender: UIButton) {
    }
    @IBAction func nextTaskButton(_ sender: UIButton) {
        appearChooseView()
    }
    @IBOutlet weak var actionCardView: UIView!
    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var contentLabel: UITextView!
    var tasks: Tasks? {
        get{
            return nil
        }
        set{
            if let tasks = newValue{
               self.concentrate = GameConcentrate(tasks: tasks)
            }
        }
    }
    var concentrate: GameConcentrate?
    override func viewDidLoad() {
        super.viewDidLoad()
        contentLabel.isEditable = false
        actionCardView.isHidden = true
        chooseView.layer.shadowRadius = 5
        chooseView.layer.shadowOpacity = 0.7
        chooseView.layer.shadowOffset = CGSize(width: 10, height: 10)
        actionCardView.layer.shadowRadius = 5
        actionCardView.layer.shadowOpacity = 0.7
        actionCardView.layer.shadowOffset = CGSize(width: 10, height: 10)
    }
    func viewNewActionTask(){
        if let task = concentrate?.getNewActionTask(){
            setEmojiLabel(emojiLabel: &emojiLabel, task: task)
            contentLabel.text = task.content
            appearActionView()
        }
        
    }
    func viewNewTruthTask(){
        if let task = concentrate?.getNewTruthTask(){
            setEmojiLabel(emojiLabel: &emojiLabel, task: task)
            contentLabel.text = task.content
            appearActionView()
        }
    }
    func setEmojiLabel(emojiLabel: inout UILabel, task: Task){
        if(task.isTruth == 1){
            emojiLabel.text = "🤫"
        } else {
            emojiLabel.text = "🤼‍♀️"
        }
    }
    func setViewActionCard(task: Task){
        setEmojiLabel(emojiLabel: &emojiLabel, task: task)
        contentLabel.text = task.content
    }
    func appearActionView() {
        let buffer_ = self.actionCardView.layer.zPosition
        self.actionCardView.layer.zPosition = self.chooseView.layer.zPosition + 10
        UIView.transition(with: self.chooseView, duration: 3, options: .transitionCurlUp, animations: {
            self.chooseView.isHidden = true
            self.actionCardView.isHidden = false
        }) { finish in
            self.actionCardView.layer.zPosition = buffer_
        }
        
    }
    func appearChooseView() {
        let buffer_ = self.chooseView.layer.zPosition
        self.chooseView.layer.zPosition = self.actionCardView.layer.zPosition + 10
        
        UIView.transition(with: self.actionCardView, duration: 3, options: .transitionCurlUp, animations: {
            self.actionCardView.isHidden = true
            self.chooseView.isHidden = false
            
        }) { finish in
            self.chooseView.layer.zPosition = buffer_
            
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
