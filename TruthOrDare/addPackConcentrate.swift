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
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.pack.count
    }
    func savePack(){
        
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
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print("iamwork lol")
    }
    override init() {
        super.init()
        NotificationCenter.default
         .addObserver(self,
                      selector:#selector(sliderDidChangeValue(_:)),
        name: NSNotification.Name ("addPack.cell.slider.didChangeValue"),                                           object: nil)
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
}

extension addPackConcentrate: NewTaskCommunicate{
    func recvNewTask(task: Task) {
        data.pack.append(TaskWithId(id: IdCounter.getId(), task: task))
        let indexPath = IndexPath(row: data.pack.count - 1, section: 0)
        delegate?.getCollectionView().insertItems(at: [indexPath])
        delegate?.getCollectionView().scrollToItem(at: indexPath, at: .bottom, animated: true)
        
    }
}
extension addPackConcentrate: ChangeCellValue{
    func changeTypeOfTask(newValue: Int, id: Int) {
        print(3113123131)
    }
    
    func changeSliderValue(newValue: Double, id: Int) {
        
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

