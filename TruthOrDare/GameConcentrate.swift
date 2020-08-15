//
//  GameConcentrate.swift
//  TruthOrDare
//
//  Created by Alexey on 12.08.2020.
//  Copyright © 2020 Alexey. All rights reserved.
//

import Foundation

class GameConcentrate{
    var truthTasks = [Task]()
    var actionTasks = [Task]()
    var deepActions = -1
    var deepTruths = -1
    private(set) var isActionNow = false
    init(tasks: Tasks) {
        var tasks_ = tasks
        tasks_.pack.shuffle()
        for task in tasks_.pack{
            if(task.isTruth == 1){
                truthTasks.append(task)
            } else {
                actionTasks.append(task)
            }
        }
    }
    func getNewActionTask() -> Task?{
        if(deepActions + 1 < self.actionTasks.count){
            deepActions += 1
            isActionNow.toggle()
            return self.actionTasks[deepActions]
        }
        else{
            return nil
        }
    }
    func getNewTruthTask() -> Task?{
        if(deepTruths + 1 < self.truthTasks.count){
            deepTruths += 1
            isActionNow.toggle()
            return self.truthTasks[deepTruths]
        }
        else{
            return nil
        }
    }
    
}
