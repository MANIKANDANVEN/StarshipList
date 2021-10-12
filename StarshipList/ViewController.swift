//
//  ViewController.swift
//  StarshipList
//
//  Created by Manikandan on 12/10/21.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
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
    var starShipModelList: Array<String> = Array()
    var favList: Array<String> = Array()
    var manufacturerList: Array<String> = Array()
    var cost_in_creditsList: Array<String> = Array()
    var lengthList: Array<String> = Array()
    var max_atmosphering_speedList: Array<String> = Array()
    var crewList: Array<String> = Array()
    var passengersList: Array<String> = Array()
    var cargo_capacityList: Array<String> = Array()
    var consumablesList: Array<String> = Array()
    var hyperdrive_ratingList: Array<String> = Array()
    var MGLTList: Array<String> = Array()
    var starship_classList: Array<String> = Array()
    var createdList: Array<String> = Array()
    var editedList: Array<String> = Array()
    var urlList: Array<String> = Array()
    
    // Access Shared Defaults Object
    let userDefaults = UserDefaults.standard
    
    // Objects
    @IBOutlet weak var activityIndicatior: UIActivityIndicatorView!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var favImage: UIImageView!
    @IBOutlet weak var showDetails: UIButton!
    @IBOutlet weak var detailsTextView: UITextView!
    var selectedName: String!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Connect data:
        self.picker.delegate = self
        self.picker.dataSource = self
        
        activityIndicatior.isHidden = true
        favImage.isHidden = true
        nameLabel.isHidden = true
        modelLabel.isHidden = true
        showDetails.isHidden = true
        detailsTextView.isHidden = true
        
        getDataFromJSON()
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            self.picker.reloadAllComponents()
            self.activityIndicatior.isHidden = true
        }
        
        
    }
    
    // Get data from URL JSON
    func getDataFromJSON(){
        activityIndicatior.isHidden = false
        if let url = URL(string: "https://swapi.dev/api/starships/?format=json") {
            URLSession.shared.dataTask(with: url) { [self] data, response, error in
        if let data = data {
        let jsonDecoder = JSONDecoder()
        do {
        let parsedJSON = try jsonDecoder.decode(mainData.self, from: data)
            print (parsedJSON.count)
            for item in parsedJSON.results {
                starShipNameList.append(item.name)
                starShipModelList.append(item.model)
                manufacturerList.append(item.manufacturer)
                cost_in_creditsList.append(item.cost_in_credits)
                lengthList.append(item.length)
                max_atmosphering_speedList.append(item.max_atmosphering_speed)
                crewList.append(item.crew)
                passengersList.append(item.passengers)
                cargo_capacityList.append(item.cargo_capacity)
                consumablesList.append(item.consumables)
                hyperdrive_ratingList.append(item.hyperdrive_rating)
                MGLTList.append(item.MGLT)
                starship_classList.append(item.starship_class)
                createdList.append(item.created)
                editedList.append(item.edited)
                urlList.append(item.url)
                    }
            
                }catch {
                    print(error)
                    let alert = UIAlertController(title: "Error", message: "Error: \(error)", preferredStyle: .alert)

                    alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))

                    self.present(alert, animated: true)
                }
               }
           }.resume()
        }
    }
    
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return starShipNameList.count
    }
        
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return starShipNameList[row]
    }
    
    // Row Selected Pickerview
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        favImage.isHidden = true
        nameLabel.isHidden = false
        modelLabel.isHidden = false
        showDetails.isHidden = false
        detailsTextView.isHidden = true
        detailsTextView.text = ""
        let selectedTitle = starShipNameList[row]
        selectedName = starShipNameList[row]
        
        if (favList.contains(selectedName)){
            favImage.isHidden = false
        }else{
            favImage.isHidden = true
        }
        
        for (i,j) in zip (starShipNameList,starShipModelList){
            if (i == selectedTitle){
                nameLabel.text = "Name: \(i)"
                modelLabel.text = "Model: \(j)"
            }
        }
        
        for (i,j) in zip (starShipNameList,manufacturerList){
            if (i == selectedTitle){
                detailsTextView.text.append("Manufacturer: \(j) \n")
            }
        }
        for (i,j) in zip (starShipNameList,cost_in_creditsList){
            if (i == selectedTitle){
                detailsTextView.text.append("Cost in credits: \(j) \n")
            }
        }
        for (i,j) in zip (starShipNameList,lengthList){
            if (i == selectedTitle){
                detailsTextView.text.append("Length: \(j) \n")
            }
        }
        for (i,j) in zip (starShipNameList,max_atmosphering_speedList){
            if (i == selectedTitle){
                detailsTextView.text.append("Max atmosphering speed: \(j) \n")
            }
        }
        for (i,j) in zip (starShipNameList,crewList){
            if (i == selectedTitle){
                detailsTextView.text.append("Crew: \(j) \n")
            }
        }
        for (i,j) in zip (starShipNameList,passengersList){
            if (i == selectedTitle){
                detailsTextView.text.append("Passengers: \(j) \n")
            }
        }
        for (i,j) in zip (starShipNameList,cargo_capacityList){
            if (i == selectedTitle){
                detailsTextView.text.append("Cargo capacity: \(j) \n")
            }
        }
        for (i,j) in zip (starShipNameList,consumablesList){
            if (i == selectedTitle){
                detailsTextView.text.append("Consumables: \(j) \n")
            }
        }
        for (i,j) in zip (starShipNameList,hyperdrive_ratingList){
            if (i == selectedTitle){
                detailsTextView.text.append("Hyperdrive rating: \(j) \n")
            }
        }
        for (i,j) in zip (starShipNameList,MGLTList){
            if (i == selectedTitle){
                detailsTextView.text.append("MGLT: \(j) \n")
            }
        }
        for (i,j) in zip (starShipNameList,starship_classList){
            if (i == selectedTitle){
                detailsTextView.text.append("Starship class: \(j) \n")
            }
        }
        for (i,j) in zip (starShipNameList,createdList){
            if (i == selectedTitle){
                detailsTextView.text.append("Created: \(j) \n")
            }
        }
        for (i,j) in zip (starShipNameList,editedList){
            if (i == selectedTitle){
                detailsTextView.text.append("Edited: \(j) \n")
            }
        }
        for (i,j) in zip (starShipNameList,urlList){
            if (i == selectedTitle){
                detailsTextView.text.append("url: \(j) \n")
            }
        }
    }
    
    // Add to Fav Function
    @IBAction func addToFav(_ sender: Any) {
        
        if (!favList.contains(selectedName)){
            favList.append(selectedName)
            favImage.isHidden = false
        }
        print(favList)
        
        // Create and Write Array of Strings
        userDefaults.set(favList, forKey: "myKey")
        UserDefaults.standard.synchronize()
        
    }
    
    // Show Details Function
    @IBAction func showDetails(_ sender: Any) {
        detailsTextView.isHidden = false
    }
    
}

