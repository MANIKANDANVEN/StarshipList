//
//  ViewController.swift
//  StarshipList
//
//  Created by Manikandan on 12/10/21.
//

import UIKit

class ViewController: UIViewController {
    
    struct mainData: Codable {
        let count: Int
        let next: String
        let previous: String?
        let results: [resultItem]
    }
    
    struct resultItem: Codable {
        let name: String
        let model: String
        let manufacturer: String
        let cost_in_credits: String
        let length: String
        let max_atmosphering_speed: String
        let crew: String
        let passengers: String
        let cargo_capacity: String
        let consumables: String
        let hyperdrive_rating: String
        let MGLT: String
        let starship_class: String
        let pilots: [String]?
        let films: [String]?
        let created: String
        let edited: String
        let url: String
    }

    // ArrayList of Names
    var starShipNameList: Array<String> = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let url = URL(string: "https://swapi.dev/api/starships/?format=json") {
            URLSession.shared.dataTask(with: url) { [self] data, response, error in
        if let data = data {
        let jsonDecoder = JSONDecoder()
        do {
        let parsedJSON = try jsonDecoder.decode(mainData.self, from: data)
            print (parsedJSON.count)
            for item in parsedJSON.results {
                starShipNameList.append(item.name)
                    }
                } catch {
        print(error)
                }
               }
           }.resume()
        }
        
        
    }
    
    
    


}

