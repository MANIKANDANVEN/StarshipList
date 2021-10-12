//
//  FavViewController.swift
//  StarshipList
//
//  Created by Manikandan on 12/10/21.
//

import UIKit

class FavViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    
    @IBOutlet weak var PickerView: UIPickerView!
    var favList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Connect data:
        self.PickerView.delegate = self
        self.PickerView.dataSource = self

        // Do any additional setup after loading the view.
        let userDefaults = UserDefaults.standard
        favList = userDefaults.object(forKey: "myKey") as! [String]
        print(favList)
        
    }
    
    
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return favList.count
    }
        
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return favList[row]
    }

    // Reload Fav data
    @IBAction func relaodFav(_ sender: Any) {
        let userDefaults = UserDefaults.standard
        favList = userDefaults.object(forKey: "myKey") as! [String]
        print(favList)
        PickerView.reloadAllComponents()
    }
    

}
