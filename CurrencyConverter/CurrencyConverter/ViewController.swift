//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Murat Han on 13.01.2020.
//  Copyright © 2020 Murat Han. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tryLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var chfLabel: UILabel!
    @IBOutlet weak var cadLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getRatesClicked(_ sender: Any) {
        
        // 1) Request & Session
        // 2) Response & Data
        // 3) Parsing & JSON Serialization
        
        //1.
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=3c99834d9a448b091601827c01d15263")
        
        let session = URLSession.shared
        
        
        //Closure
        let task = session.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert,animated: true, completion: nil)
            }else {
                //2.
                if data != nil {
                   
                    do{
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary <String, Any>
                        
                        //ASYNC
                        DispatchQueue.main.async {
                            if let rates = jsonResponse["rates"] as? [String : Any] {
                                
                                //printing rates
                                if let cad = rates["CAD"] as? Double {
                                    self.cadLabel.text = "CAD : \(cad)"
                                }
                                if let chf = rates["CHF"] as? Double {
                                    self.chfLabel.text = "CHF : \(chf)"
                                }
                                if let gbp = rates["GBP"] as? Double {
                                    self.gbpLabel.text = "GBP : \(gbp)"
                                }
                                if let jpy = rates["JPY"] as? Double {
                                    self.jpyLabel.text = "JPY : \(jpy)"
                                }
                                if let usd = rates["USD"] as? Double {
                                    self.usdLabel.text = "USD : \(usd)"
                                }
                                if let tl = rates["TRY"] as? Double {
                                    self.tryLabel.text = "TRY : \(tl)"
                                }
                            }
                        }
                        
                        
                    } catch {
                        print("error")
                    }
                }
            }
        }
        
        task.resume()
        
    }
    
}

