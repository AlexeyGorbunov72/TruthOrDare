//
//  AddTaskViewController.swift
//  TruthOrDare
//
//  Created by Alexey on 26.08.2020.
//  Copyright © 2020 Alexey. All rights reserved.
//

import UIKit

protocol NewTaskCommunicate{
    func recvNewTask() -> Task
}
class AddTaskViewController: UIViewController {
    var delegate: NewTaskCommunicate?
    var isTruthChoosen = true
    let placeholderColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
    let task = Task(levelOfHard: "", content: "", isTruth: 1)
    @IBOutlet weak var segmentedTruthOrDare: UISegmentedControl!
    
    @IBOutlet weak var textViewOfTask: UITextView!
    
    
    @IBAction func changeSegmentedTruthOrDare(_ sender: UISegmentedControl) {
        isTruthChoosen.toggle()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        textViewOfTask.text = "Пиши сюда свое задание"
        textViewOfTask.textColor = placeholderColor
        textViewOfTask.backgroundColor = .systemIndigo
        textViewOfTask.delegate = self
        textViewOfTask.font = .preferredFont(forTextStyle: .headline)
        textViewOfTask.layer.borderWidth = 3
        textViewOfTask.layer.borderColor = #colorLiteral(red: 1, green: 0.4949137568, blue: 0.4754163027, alpha: 1)
        textViewOfTask.layer.cornerRadius = 10
        textViewDidChange(textViewOfTask)
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        segmentedTruthOrDare.setTitleTextAttributes(titleTextAttributes, for: .normal)
        segmentedTruthOrDare.setTitleTextAttributes(titleTextAttributes, for: .selected)
        
    }
    

}
extension AddTaskViewController: UITextViewDelegate{
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
