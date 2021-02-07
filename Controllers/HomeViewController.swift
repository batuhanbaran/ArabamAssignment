//
//  ViewController.swift
//  ArabamAssignment
//
//  Created by Batuhan Baran on 27.01.2021.
//

import UIKit
import SDWebImage
import AYPopupPickerView

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet var tableView: UITableView!
    
    var carModel = [CarModel]()

    private var take = 10
    private var skip = 0
    private var sampleDataCountLimit = 100
    
    private var sort = 1
    private var sortDirection = 0

    @IBOutlet var filterLabel: UILabel!
    static var isFiltered: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //navBar customization...
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2, green: 0.06666666667, blue: 0.7647058824, alpha: 1)
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,NSAttributedString.Key.font:UIFont(name: "Arial", size: 17)]
        navigationController?.navigationBar.titleTextAttributes = textAttributes as [NSAttributedString.Key : Any]
        self.navigationItem.title = "2. El"
        
        
        //tableView delegates programmatically
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
            
        //MARK:- call fetchData func
  
        Service().fetchData(sort: self.sort, sortDirection: self.sortDirection, skip: self.skip,take: self.take) { (results) in
            
            switch results{
            
            case .success(let cars):
                
                self.carModel.append(contentsOf: cars)

                DispatchQueue.main.async {
                    
                    self.tableView.reloadData()

                }
                
            case .failure(let error):
                
                print(error.localizedDescription)
            }
        }

    }
    
    //MARK:- tableView methods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return carModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! HomeViewTableViewCell
        cell.selectionStyle = .none
        
        cell.title.text = carModel[indexPath.row].title
        cell.location.text = "📍 " + carModel[indexPath.row].location.cityName + ", " + carModel[indexPath.row].location.townName
        cell.price.text = carModel[indexPath.row].priceFormatted
        
        let imageUrl = URL(string: "\(carModel[indexPath.row].photo.replacingOccurrences(of: "{0}", with: "800x600"))")
        
        if let url = imageUrl{
            
            cell.carImage!.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "placeholderImage"))
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //saving and pushing advert id of selected advert
        UserDefaults.standard.setValue(carModel[indexPath.row].id, forKey: "selectedId")
        
        self.performSegue(withIdentifier: "toDetailVC", sender: nil)
    }
    

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        
        //pagination, also we can use willdisplaycell method of tableview...

        if scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.frame.size.height{

            self.skip += 10

            if self.carModel.count <= self.sampleDataCountLimit && !HomeViewController.isFiltered{
                
                print("filtreisiz")

                Service().fetchData(sort: self.sort, sortDirection: self.sortDirection, skip: self.skip,take: self.take) { (result) in

                    switch result{

                    case .success(let cars):

                        self.carModel.append(contentsOf: cars)

                        DispatchQueue.main.async {

                            self.tableView.reloadData()

                        }

                    case .failure(let error):

                        print(error.localizedDescription)
                    }
                }
            }
            
            if self.carModel.count <= self.sampleDataCountLimit && HomeViewController.isFiltered{
                
                print("filtreli")

                let minYear = UserDefaults.standard.string(forKey: "minYear")
                let maxYear = UserDefaults.standard.string(forKey: "maxYear")
                
                if minYear != nil && maxYear != nil{
                    
                    Service().fetchDataWithFilter(minYear: minYear!, maxYear: maxYear!, sort: self.sort, sortDirection: self.sortDirection, skip: self.skip, take: self.take) { (result) in
                        
                        switch result{
                        
                        case .success(let cars):
                            
                            
                            self.carModel.append(contentsOf: cars)
                            
                            DispatchQueue.main.async {
                                
                                self.tableView.reloadData()

                            }
                            
                        case .failure(let error):
                            
                            print(error.localizedDescription)
                        }
                    }
                }
            }

        }
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 120
    }
    
    @IBAction func sortButton(_ sender: Any) {
        
        
        let itemsTitle = ["Gelişmiş Sıralama","Fiyat - ucuzdan pahalıya", "Fiyat - pahalıdan ucuza", "İlan tarihi - yeniden eskiye", "Model yılı - yeniden eskiye"]
        
        let popupPickerView = AYPopupPickerView()
        
        
        //some customization
        
        popupPickerView.headerView.backgroundColor = UIColor.white
        popupPickerView.doneButton.setTitle("Seç", for: .normal)
        popupPickerView.doneButton.setTitleColor(.systemRed, for: .normal)
        popupPickerView.cancelButton.setTitle("Vazgeç", for: .normal)
        popupPickerView.cancelButton.setTitleColor(.systemRed, for: .normal)
        
        popupPickerView.display(itemTitles: itemsTitle, doneHandler: {
            
            let selectedIndex = popupPickerView.pickerView.selectedRow(inComponent: 0)
            
            switch selectedIndex{
            
            case 0:
                
                self.sort = 1
                self.sortDirection = 0
                
            case 1:
                
                
                self.sort = 0
                self.sortDirection = 0
                
            case 2:
                
                self.sort = 0
                self.sortDirection = 1
            

            case 3:
                
                self.sort = 1
                self.sortDirection = 1
                
            case 4:
                
                self.sort = 2
                self.sortDirection = 1
                
            default:
                
                break
            }

            if !HomeViewController.isFiltered{
                
                Service().fetchData(sort: self.sort, sortDirection: self.sortDirection, skip: self.skip,take: self.take) { (results) in
                    
                    switch results{
                    
                    case .success(let cars):
                        
                        self.carModel.removeAll(keepingCapacity: false)
                        self.carModel.append(contentsOf: cars)
                        
                        DispatchQueue.main.async {
                            
                            self.tableView.reloadData()

                        }
                        
                    case .failure(let error):
                        
                        print(error.localizedDescription)
                    }
                }
                
            }else{
                
                let minYear = UserDefaults.standard.string(forKey: "minYear")
                let maxYear = UserDefaults.standard.string(forKey: "maxYear")
                
                if minYear != nil && maxYear != nil && HomeViewController.isFiltered{
                    
                    Service().fetchDataWithFilter(minYear: minYear!, maxYear: maxYear!, sort: self.sort, sortDirection: self.sortDirection, skip: self.skip, take: self.take) { (result) in
                        
                        switch result{
                        
                        case .success(let cars):
                            
                            self.carModel.removeAll(keepingCapacity: false)
                            self.carModel.append(contentsOf: cars)
                            
                            DispatchQueue.main.async {
                                
                                self.tableView.reloadData()
                                self.filterLabel.text = "Filter (1)"
                            }
                            
                        case .failure(let error):
                            
                            print(error.localizedDescription)
                        }
                    }
                    
                }
            }
            
        })
        
        self.tableView.scrollsToTop = true

    }

    @IBAction func filterButton(_ sender: Any) {
        
        self.performSegue(withIdentifier: "toFilterVC", sender: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let minYear = UserDefaults.standard.string(forKey: "minYear")
        let maxYear = UserDefaults.standard.string(forKey: "maxYear")
        
        if minYear != nil && maxYear != nil && HomeViewController.isFiltered{
            
            Service().fetchDataWithFilter(minYear: minYear!, maxYear: maxYear!, sort: self.sort, sortDirection: self.sortDirection, skip: self.skip, take: self.take) { (result) in
                
                switch result{
                
                case .success(let cars):
                    
                    self.carModel.removeAll(keepingCapacity: false)
                    self.carModel.append(contentsOf: cars)
                    
                    DispatchQueue.main.async {
                        
                        self.tableView.reloadData()
                        self.filterLabel.text = "Filter (1)"
                    }
                    
                case .failure(let error):
                    
                    print(error.localizedDescription)
                }
            }
            
        }
        if minYear == nil && maxYear == nil && !HomeViewController.isFiltered{
            
            //when filter is clear...
            self.filterLabel.text = "Filter"
            self.skip = 0
            self.sort = 1
            self.sortDirection = 0
            
            Service().fetchData(sort: self.sort, sortDirection: self.sortDirection, skip: self.skip,take: self.take) { (results) in
                
                switch results{
                
                case .success(let cars):
                    
                    self.carModel.removeAll(keepingCapacity: false)
                    self.carModel.append(contentsOf: cars)

                    DispatchQueue.main.async {
                        
                        self.tableView.reloadData()

                    }
                    
                case .failure(let error):
                    
                    print(error.localizedDescription)
                }
            }
            
            
        }
        

    }
    
}
