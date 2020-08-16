//
//  ViewController.swift
//  TruthOrDare
//
//  Created by Alexey on 12.08.2020.
//  Copyright © 2020 Alexey. All rights reserved.
//

import UIKit
import Foundation
class ViewController: UIViewController {
    @IBOutlet weak var pic: UIImageView!
    @IBOutlet weak var newPackButton: UIButton!
    @IBOutlet weak var newGameButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        pic.rotate()
        newGameButton.titleLabel?.font = .boldSystemFont(ofSize: 30)
        newGameButton.layer.cornerRadius = newGameButton.frame.height / 2
        newPackButton.titleLabel?.font = .boldSystemFont(ofSize: 30)
        newPackButton.layer.cornerRadius = newGameButton.frame.height / 2
    }
    override func viewDidAppear(_ animated: Bool) {
        pic.rotate()
    }


}
extension UIView{
    func rotate() {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.y")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 10
        rotation.isCumulative = true
        rotation.repeatCount = .greatestFiniteMagnitude
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
}
