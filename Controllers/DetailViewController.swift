//
//  DetailViewController.swift
//  ArabamAssignment
//
//  Created by Batuhan Baran on 27.01.2021.
//

import UIKit
import SDWebImage
import ImageSlideshow

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet var carTitle: UILabel!
    @IBOutlet var tableView: UITableView!
 
    
    @IBOutlet var imageSlideshow: ImageSlideshow!
    var imageSources = [SDWebImageSource]()
    var imageUrls = [String]()
    
    var carDetailModel: CarDetail!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        

        imageSlideshow.contentScaleMode = .scaleAspectFill
        
        let tapImage = UITapGestureRecognizer(target: self, action: #selector(self.tapImage(_:)))
        imageSlideshow.addGestureRecognizer(tapImage)

        
        getCarByAdvertId(id: UserDefaults.standard.integer(forKey: "selectedId"))
        

    }
    
    //MARK:- fetching details
    
    func getCarByAdvertId(id: Int){


        Service().fetchCarDetail(advertId: id) { (result) in
            
            switch result{
            
            case .success(let carDetail):
                
                self.carDetailModel = carDetail
               
                DispatchQueue.main.sync {

                    self.tableView.delegate = self
                    self.tableView.dataSource = self
                    self.tableView.reloadData()
                    
                    self.carTitle.text = self.carDetailModel.title

                    //handling photo urls
                    for photo in self.carDetailModel.photos{

                        self.imageSources.append(SDWebImageSource(urlString: photo.replacingOccurrences(of: "{0}", with: "800x600"))!)
                        self.imageUrls.append(photo.replacingOccurrences(of: "{0}", with: "800x600"))

                    }
                    self.imageSlideshow.setImageInputs(self.imageSources)
                    
                }
                

            case .failure(let error):
                
                print(error.localizedDescription)
            }
            
        }
    

    }
    
    //MARK:- tableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0{
            
            return 3
        }
        
        if section == 1{
            
            return self.carDetailModel.properties.count
        }
        
        if section == 2{
            
            return 2
        }
        
        return Int()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
     
        cell!.selectionStyle = .none
        self.tableView.separatorStyle = .none
        
        if indexPath.row % 2 == 1{
            
            cell!.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.2522715385)
        }

        
        //sections
        
        if indexPath.section == 0{


            switch indexPath.row {
            
            case 0:
                
                cell?.textLabel?.text = "Price"
                cell?.detailTextLabel?.text = self.carDetailModel.priceFormatted
                
            case 1:
                
                cell?.textLabel?.text = "Model Name"
                cell?.detailTextLabel?.text = self.carDetailModel.modelName
                
            case 2:
                
                cell?.textLabel?.text = "Date"
                cell?.detailTextLabel?.text = self.carDetailModel.dateFormatted

            default: break
                
            }


        }

        if indexPath.section == 1{
            
            cell?.textLabel?.text = self.carDetailModel.properties[indexPath.row].name.capitalizingFirstLetter()
            cell?.detailTextLabel?.text = self.carDetailModel.properties[indexPath.row].value

        }
        
        if indexPath.section == 2{


            switch indexPath.row {
            
            case 0:
                
                cell?.textLabel?.text = "Name&Surname"
                cell?.detailTextLabel?.text = self.carDetailModel.userInfo.nameSurname
                
            case 1:
                
                cell?.textLabel?.text = "Phone"
                cell?.detailTextLabel?.text = self.carDetailModel.userInfo.phone
                


            default: break
                
            }


        }
        
        return cell!
        
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {

        return 3
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        if section == 0{

            return "Advert Info"
        }
        if section == 1{

            return "Properties"
        }
        
        if section == 2{

            return "User Info"
        }

        return ""
    }
    
    @objc func tapImage(_ sender: UITapGestureRecognizer? = nil) {
        
        UserDefaults.standard.set(self.imageUrls, forKey: "imageUrls")
        self.performSegue(withIdentifier: "imagePage", sender: nil)
    }
    @IBAction func callButton(_ sender: Any) {
        
        //When the action sheet opens, it gives an error about constraints. According to my research, this is a bug.
        //https://stackoverflow.com/questions/55372093/uialertcontrollers-actionsheet-gives-constraint-error-on-ios-12-2-12-3
        
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let callAction = UIAlertAction(title: "Call", style: .default) { (action) in

            //calling someone 😬
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in

        }

        actionSheet.addAction(callAction)
        actionSheet.addAction(cancelAction)

        self.present(actionSheet, animated: true, completion: nil)
    }
    
}



//MARK:- extension for capitalizing the first letter of prop. name...

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
