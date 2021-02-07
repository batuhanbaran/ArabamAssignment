//
//  FilterViewController.swift
//  ArabamAssignment
//
//  Created by Batuhan Baran on 6.02.2021.
//

import UIKit

class FilterViewController: UIViewController {

    @IBOutlet var minYear: UITextField!
    @IBOutlet var maxYear: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()


        //barItems...
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(clearButton))
       
        if HomeViewController.isFiltered{
            
            self.minYear.text = UserDefaults.standard.string(forKey: "minYear")
            self.maxYear.text = UserDefaults.standard.string(forKey: "maxYear")
        }
        
    }
    
    @objc func clearButton(){
        
        if minYear.text != "" && maxYear.text != ""{

            
            UserDefaults.standard.setValue(nil, forKey: "minYear")
            UserDefaults.standard.setValue(nil, forKey: "maxYear")
            
            self.minYear.text = ""
            self.maxYear.text = ""

            
        }
        
    }
    @IBAction func applyFilter(_ sender: Any) {
        
        if minYear.text != "" && maxYear.text != ""{
            
            
            HomeViewController.isFiltered = true
            
            UserDefaults.standard.setValue(minYear.text!, forKey: "minYear")
            UserDefaults.standard.setValue(maxYear.text!, forKey: "maxYear")
            
            self.dismiss(animated: true, completion: nil)
            
        }
        
        
        if minYear.text == "" && maxYear.text == ""{
            
            HomeViewController.isFiltered = false
            self.dismiss(animated: true, completion: nil)
            
        }
    }
    
    @objc func cancelButton(){

        
        if minYear.text == "" && maxYear.text == ""{
            
            HomeViewController.isFiltered = false
            self.dismiss(animated: true, completion: nil)
            
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
