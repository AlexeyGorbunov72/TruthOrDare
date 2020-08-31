//
//  addPackConcentrate.swift
//  TruthOrDare
//
//  Created by Alexey on 21.08.2020.
//  Copyright © 2020 Alexey. All rights reserved.
//

import UIKit
protocol getCell: needsReload{
    func getCell(indexPath: IndexPath) -> UICollectionViewCell
    func reloadCollectionViewPlease()
}
protocol ChangeCellValue: class{
    func changeTypeOfTask(newValue: Int, id: Int)
    func changeSliderValue(newValue: Double, id: Int)
}
protocol GetCollectionView{
    func getCollectionView() -> UICollectionView
}
struct IdCounter {
    static var idOfCell = 0
    static func getId() -> Int{
        IdCounter.idOfCell += 1
        return IdCounter.idOfCell
    }
    
}
class addPackConcentrate: NSObject, UICollectionViewDataSource{
    var data = TasksWithId(pack: [])
    var delegate: GetCollectionView?
    var textFieldAlert: UITextField?
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.pack.count
    }
    func handleTextField(textField: UITextField!){
        if (textField) != nil {
            self.textFieldAlert = textField!
            self.textFieldAlert?.placeholder = "Твое название:";
        }
    }
    func savePackLocaly(){
        APIDatabase.savePack(pack: self.getPack(), tasks: self.getTasks())
    }
    private func getPack() -> Pack{
        var levelAction = 0.0
        var levelTruth = 0.0
        data.pack.forEach{ (taskWithId) in
            if taskWithId.task.isTruth == 0{
                levelAction += Double(taskWithId.task.levelOfHard)!
            } else {
                levelTruth += Double(taskWithId.task.levelOfHard)!
            }
        }
        let newPack = Pack.init(id: -1, title: textFieldAlert?.text ?? "???", levelAction: String(levelAction), levelTruth: String(levelTruth))
        return newPack
        
        
    }
    private func getTasks() -> [Task]{
        var tasks: [Task] = []
        data.pack.forEach{ (taskWithId) in
            tasks.append(taskWithId.task)
        }
        return tasks
    }
    func animatePlease(_ indexPath: IndexPath, cell: UICollectionViewCell){
        if let cell = cell as? addPackCollectionViewCell{
            cell.animateSlider(value: data.pack[indexPath.row].task.levelOfHard)
            
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! addPackCollectionViewCell
        cell.data = data.pack[indexPath.row].task
        cell.idOfCell = data.pack[indexPath.row].id
        return cell
    }
    
    
    override init() {
        super.init()
        NotificationCenter.default
         .addObserver(self,
                      selector:#selector(sliderDidChangeValue(_:)),
        name: NSNotification.Name ("addPack.cell.slider.didChangeValue"),                                           object: nil)
        NotificationCenter.default
         .addObserver(self,
                      selector:#selector(typeButtonDidChangeValue(_:)),
        name: NSNotification.Name ("addPack.cell.button.didPress"),                                           object: nil)
        
    }
    @objc func sliderDidChangeValue(_ notification: Notification){
        if let id = notification.userInfo?["id"] as? Int{
            if let newValue = notification.userInfo?["value"] as? Float{
                for i in 0..<data.pack.count{
                    if id == data.pack[i].id{
                        data.pack[i].task.levelOfHard = String(newValue)
                    }
                }
            }
        }
    }
    @objc func typeButtonDidChangeValue(_ notification: Notification){
        if let id = notification.userInfo?["id"] as? Int{
            for i in 0..<data.pack.count{
                if id == data.pack[i].id{
                    data.pack[i].task.isTruth = data.pack[i].task.isTruth == 1 ? 0 : 1
                }
            }
        }
    }
}

extension addPackConcentrate: NewTaskCommunicate{
    func recvNewTask(task: Task) {
        data.pack.append(TaskWithId(id: IdCounter.getId(), task: task))
        let indexPath = IndexPath(row: data.pack.count - 1, section: 0)
        delegate?.getCollectionView().insertItems(at: [indexPath])
        delegate?.getCollectionView().scrollToItem(at: indexPath, at: .bottom, animated: true)
        
    }
}


class TaskWithId{
    var id: Int
    var task: Task
    init(id: Int, task: Task) {
        self.task = task
        self.id = id
    }
    
}
struct TasksWithId{
    var pack: [TaskWithId]
}

