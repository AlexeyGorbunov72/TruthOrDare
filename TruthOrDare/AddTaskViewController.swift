//
//  AddTaskViewController.swift
//  TruthOrDare
//
//  Created by Alexey on 26.08.2020.
//  Copyright © 2020 Alexey. All rights reserved.
//

import UIKit

protocol NewTaskCommunicate{
    func recvNewTask(task: Task)
}
class AddTaskViewController: UIViewController {
    var delegate: NewTaskCommunicate?
    var isTruthChoosen = true
    let placeholderColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
    let placeholderText = "Пиши сюда свое задание"
    var task = Task(levelOfHard: "", content: "", isTruth: 1)
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var segmentedTruthOrDare: UISegmentedControl!
    
    @IBOutlet weak var textViewOfTask: UITextView!
    
    
    @IBAction func changeSegmentedTruthOrDare(_ sender: UISegmentedControl) {
        isTruthChoosen.toggle()
    }
    @IBAction func pressAddButton(_ sender: UIButton) {
        let contentOfTask = textViewOfTask.text.trimmingCharacters(in: .whitespacesAndNewlines)
        if contentOfTask == "" || contentOfTask == placeholderText{
            let alert = UIAlertController(title: "Что-то пошло не так...", message: "похоже ты ничего не указал в поле задания(", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ок", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        task.content = contentOfTask
        task.isTruth = isTruthChoosen ? 1 : 0
        task.levelOfHard = "5"
        delegate?.recvNewTask(task: task)
        self.dismiss(animated: true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addButton.setImage(UIImage(systemName: "plus")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        addButton.layer.cornerRadius = addButton.frame.height / 2
        addButton.backgroundColor = #colorLiteral(red: 1, green: 0.4949137568, blue: 0.4754163027, alpha: 1)
        addButton.layer.shadowOpacity = 0.7
        addButton.layer.shadowRadius = 5
        
        
        
        textViewOfTask.text = placeholderText
        textViewOfTask.textColor = placeholderColor
        textViewOfTask.backgroundColor = .systemIndigo
        textViewOfTask.delegate = self
        textViewOfTask.font = .preferredFont(forTextStyle: .title1)
        textViewOfTask.layer.borderWidth = 3
        textViewOfTask.layer.borderColor = #colorLiteral(red: 1, green: 0.4949137568, blue: 0.4754163027, alpha: 1)
        textViewOfTask.layer.cornerRadius = 10
        textViewDidChange(textViewOfTask)
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        segmentedTruthOrDare.setTitleTextAttributes(titleTextAttributes, for: .normal)
        segmentedTruthOrDare.setTitleTextAttributes(titleTextAttributes, for: .selected)
        segmentedTruthOrDare.layer.shadowOpacity = 0.5
        segmentedTruthOrDare.layer.shadowRadius = 5
        
    }
    

}
extension AddTaskViewController: UITextViewDelegate{
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textViewOfTask.textColor == placeholderColor{
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {[unowned self] in
                self.textViewOfTask.textColor = .white
                textView.text = ""
                self.view.layoutIfNeeded()
            })
            
        }
    }
    func textViewDidChange(_ textView: UITextView) {
        
        textViewOfTask.text = textViewOfTask.text.trimmingCharacters(in: .newlines)
        let size = CGSize(width: textViewOfTask.frame.width, height: .infinity)
        let estimatedSize = textViewOfTask.sizeThatFits(size)
        textViewOfTask.constraints.forEach{(constraint) in
            if constraint.firstAttribute == .height{
                UIView.animate(withDuration: 0.2, delay: 0,
                               options: [.curveEaseInOut],
                               animations: { [unowned self] in
                              constraint.constant = estimatedSize.height
                            self.view.layoutIfNeeded()
                }, completion: nil)
                
            }
        }
    }
}
