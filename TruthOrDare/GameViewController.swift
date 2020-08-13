//
//  GameViewController.swift
//  TruthOrDare
//
//  Created by Alexey on 12.08.2020.
//  Copyright © 2020 Alexey. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    var packId: String
    lazy var concentrate = Concentrate(packId)
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    required init?(coder aDecoder: NSCoder) {
        packId = "defoult"
        super.init(coder: aDecoder)
    }

}
