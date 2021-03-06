//
//  Pokemon.swift
//  Pokedex
//
//  Created by Malcolm Kumwenda on 2017/06/13.
//  Copyright © 2017 ByteOrbit. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Pokemon {
    var name: String!
    var pokedexId: Int!
    var description: String?
    var type: String?
    var defense: String?
    var height: String?
    var weight: String?
    var attack: String?
    var nextEvolutionText: String?
    
    init(name: String, pokedexID: Int){
        self.name = name
        self.pokedexId = pokedexID
    }
    
    func downloadDetails(completed: @escaping ()->()){
        Alamofire.request(API.pokemon(pokedexId).endPoint).responseJSON(completionHandler: { response in
            print(response)
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let height = json["height"].int
                let weight = json["weight"].int
                let type = json["types"][0]["type"]["name"].string
                let defense = json["stats"][3]["base_stat"].int
                let attack = json["stats"][0]["base_stat"].int
                self.height = "\(height ?? 0)"
                self.weight = "\(weight ?? 0)"
                self.type = type
                self.defense = "\(defense ?? 0)"
                self.attack = "\(attack ?? 0)"
            case .failure(let error):
                print(error)
            }
            completed()
        })
    }
}

