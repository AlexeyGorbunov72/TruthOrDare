//
//  GameViewController.swift
//  TruthOrDare
//
//  Created by Alexey on 12.08.2020.
//  Copyright © 2020 Alexey. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    let gameOver = UIAlertController(title: "Карточки кончились", message: "Покидаем помещение молодые люди", preferredStyle: UIAlertController.Style.alert)
    
    @IBOutlet weak var claseButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var chooseView: UIView!
    
    @IBAction func chooseAction(_ sender: UIButton) {
        viewNewActionTask()
    }
    @IBAction func chooseTruth(_ sender: UIButton) {
        viewNewTruthTask()
    }
    @IBAction func closeGameButton(_ sender: UIButton) {
        let navc = storyboard?.instantiateViewController(identifier: "start") as! UINavigationController
        navc.modalPresentationStyle = .fullScreen
        present(navc, animated: true)
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
        gameOver.addAction(UIAlertAction(title: "ок", style: UIAlertAction.Style.default, handler: nil))
        nextButton.layer.cornerRadius = nextButton.frame.height / 2
        nextButton.clipsToBounds = true
        claseButton.layer.cornerRadius = claseButton.frame.height / 2
        claseButton.clipsToBounds = true
        claseButton.layer.shadowOpacity = 0.5
        claseButton.layer.shadowRadius = 5
        contentLabel.isEditable = false
        actionCardView.isHidden = true
        actionCardView.layer.shadowRadius = 5
        actionCardView.layer.shadowOpacity = 0.7
        actionCardView.layer.shadowOffset = CGSize(width: 10, height: 10)
        chooseView.layer.shadowRadius = 5
        chooseView.layer.shadowOpacity = 0.7
        chooseView.layer.shadowOffset = CGSize(width: 10, height: 10)
        
        
        
    }
    func viewNewActionTask(){
        if let task = concentrate?.getNewActionTask(){
            setEmojiLabel(emojiLabel: &emojiLabel, task: task)
            contentLabel.text = task.content
            appearActionView()
        } else {
            if (concentrate?.isGameOver())!{
                self.present(gameOver, animated: true, completion: nil)
            }
        }
        
    }
    func viewNewTruthTask(){
        if let task = concentrate?.getNewTruthTask(){
            setEmojiLabel(emojiLabel: &emojiLabel, task: task)
            contentLabel.text = task.content
            appearActionView()
        } else {
            if (concentrate?.isGameOver())!{
                self.present(gameOver, animated: true, completion: nil)
            }
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
        
        self.chooseView.isHidden = true
        UIView.transition(with: self.actionCardView, duration: 0.5, options: .transitionFlipFromLeft, animations: { [unowned self] in
            self.actionCardView.isHidden = false
        })
        
        
    }
    func appearChooseView() {
        self.actionCardView.isHidden = true
        UIView.transition(with: self.chooseView, duration: 0.5, options: .transitionFlipFromLeft, animations: { [unowned self] in
            self.chooseView.isHidden = false
            
        })
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
