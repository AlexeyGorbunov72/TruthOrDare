//
//  APITruthOrDare.swift
//  TruthOrDare
//
//  Created by Alexey on 29.08.2020.
//  Copyright © 2020 Alexey. All rights reserved.
//

import Foundation
private struct APISetup{
    static let ip = "192.168.0.12:"
    static let port = "8000"

}
struct APITruthOrDare {
    static func getPackContent(_ id: Int, completionBlock: @escaping (Tasks) -> Void){
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
    static func getAllPacks(completionBlock: @escaping (Packs) -> Void){
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
}

private struct APIRequests{
    static let getPacks = "http://\(APISetup.ip)\(APISetup.port)/api/getPacks"
    static let getContentOfPack = "http://\(APISetup.ip)\(APISetup.port)/api/getContentOfPack/"
}
