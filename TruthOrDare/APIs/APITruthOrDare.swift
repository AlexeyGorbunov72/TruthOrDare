//
//  APITruthOrDare.swift
//  TruthOrDare
//
//  Created by Alexey on 29.08.2020.
//  Copyright © 2020 Alexey. All rights reserved.
//

import Foundation
private struct APISetup{
    static let ip = "192.168.0.12"
    static let port = "8000"

}
class APITruthOrDare: PacksManager {
    func getPackContent(_ id: Int, completionBlock: @escaping (Tasks) -> Void){
        if let url = URL(string: String(APIRequests.getContentOfPack + String(id))){
            URLSession.shared.dataTask(with: url){data, res, err in
                if let data = data{
                
                    let decoder = JSONDecoder()
                    if let json = try? decoder.decode(Tasks.self, from: data){
                        completionBlock(json)
                    }
                }
                else{
                }
            }.resume()
        }
    }
    func getAllPacks(completionBlock: @escaping (Packs) -> Void){
        if let url = URL(string: APIRequests.getPacks){
            URLSession.shared.dataTask(with: url){data, res, err in
                if let data = data{
                    let decoder = JSONDecoder()
                    if let json = try? decoder.decode(Packs.self, from: data){
                        completionBlock(json)
                    }
                }
            }.resume()
        }
    }
    func savePack(pack: Pack, tasks: [Task]){
        let setToEncodeJson = SetToEncodeJson()
        setToEncodeJson.pack = pack
        setToEncodeJson.tasks = tasks
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(setToEncodeJson)
        print(String(data: jsonData!, encoding: String.Encoding.utf8))
        
        var request = URLRequest(url: URL(string: APIRequests.loadPack)!)
        request.httpMethod = "POST"
        request.httpBody = jsonData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
        }

        task.resume()
        
    }
    
    private func convertPackForJsonEncode(pack: Pack) -> PackForJson{
        var packForJson = PackForJson()
        packForJson += pack
        return packForJson
    }
    
    private func convertTaskForJsonEncode(task: Task) -> TaskForJson{
        var taskForJson = TaskForJson()
        taskForJson += task
        return taskForJson
    }
}


private class PackForJson: Codable{
    var title: String?
    var levelAction: String?
    var levelTruth: String?
    
    static func +=( left: inout PackForJson, pack: Pack){
        left.title = pack.title
        left.levelAction = pack.levelAction
        left.levelTruth = pack.levelTruth
    }
}
private class TaskForJson: Codable{
    var levelOfHard: String?
    var content: String?
    var isTruth: Int?
    static func +=( left: inout TaskForJson, task: Task){
        left.levelOfHard = task.levelOfHard
        left.content = task.content
        left.isTruth = task.isTruth
    }
}
private class SetToEncodeJson: Codable{
    var pack: Pack?
    var tasks: [Task]?
    
}
private struct APIRequests{
    static let getPacks = "http://\(APISetup.ip):\(APISetup.port)/api/getPacks"
    static let getContentOfPack = "http://\(APISetup.ip):\(APISetup.port)/api/getContentOfPack/"
    static let loadPack = "http://\(APISetup.ip):\(APISetup.port)/api/loadPack"
}
