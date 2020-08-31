//
//  PacksManager.swift
//  TruthOrDare
//
//  Created by Alexey on 01.09.2020.
//  Copyright © 2020 Alexey. All rights reserved.
//

import Foundation
protocol PacksManager {
    static func getPackContent(_ id: Int, completionBlock: @escaping (Tasks) -> Void)
    static func getAllPacks(completionBlock: @escaping (Packs) -> Void)
}
