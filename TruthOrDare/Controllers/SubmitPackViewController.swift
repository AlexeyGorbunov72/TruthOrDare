//
//  SubmitPackViewController.swift
//  TruthOrDare
//
//  Created by Alexey on 31.08.2020.
//  Copyright © 2020 Alexey. All rights reserved.
//

import UIKit

class SubmitPackViewController: UIViewController {
    let placeholderColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
    let placeholderText = "Пиши сюда свое задание"
    var pack: Pack?
    var tasks: [Task]?
    @IBOutlet weak var savePackButton: UIButton!
    @IBAction func pressSaveButton(_ sender: Any) {
    }
    @IBOutlet weak var segment: UISegmentedControl!
    @IBAction func segmentChange(_ sender: Any) {
    }
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        textView.text = placeholderText
        textView.textColor = placeholderColor
        textView.backgroundColor = .systemIndigo
        textView.delegate = self
        textView.font = .preferredFont(forTextStyle: .title1)
        textView.layer.borderWidth = 3
        textView.layer.borderColor = #colorLiteral(red: 1, green: 0.4949137568, blue: 0.4754163027, alpha: 1)
        textView.layer.cornerRadius = 10
        textViewDidChange(textView)
        
    }
    

}
extension SubmitPackViewController: UITextViewDelegate{
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == placeholderColor{
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {[unowned self] in
                self.textView.textColor = .white
                textView.text = ""
                self.view.layoutIfNeeded()
            })
            
        }
    }
    func textViewDidChange(_ textView: UITextView) {
        
        textView.text = textView.text.trimmingCharacters(in: .newlines)
        let size = CGSize(width: textView.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        textView.constraints.forEach{(constraint) in
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
