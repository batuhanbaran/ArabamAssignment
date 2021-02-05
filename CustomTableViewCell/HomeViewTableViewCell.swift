//
//  HomeViewTableViewCell.swift
//  ArabamAssignment
//
//  Created by Batuhan Baran on 28.01.2021.
//

import UIKit

class HomeViewTableViewCell: UITableViewCell {
    
    @IBOutlet var title: UILabel!
    @IBOutlet var location: UILabel!
   
    @IBOutlet var carImage: UIImageView!
    @IBOutlet var price: UILabel!
    
    
    
    //    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//
//
//    }
//
//
//    lazy var carImage: UIImageView = {
//
//        let carImage = UIImageView(frame: CGRect(x: 10, y: 0, width: 80, height: 80))
//        carImage.contentMode = .scaleAspectFit
//
//        return carImage
//    }()
//
//    lazy var title: UILabel = {
//
//        let lbl = UILabel(frame: CGRect(x: self.carImage.frame.width + 20, y: -5, width: self.contentView.frame.width - 50, height: 50))
//        //lbl.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
//        lbl.textAlignment = .left
//        lbl.font = UIFont.boldSystemFont(ofSize: 13)
//
//
//        return lbl
//    }()
//
//    lazy var location: UILabel = {
//
//        let lbl = UILabel(frame: CGRect(x: self.carImage.frame.width + 20, y: 46, width: self.contentView.frame.width - 100, height: 30))
//        lbl.textAlignment = .left
//        lbl.font = UIFont(name: "Arial", size: 12)
//        //lbl.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
//        lbl.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
//        return lbl
//    }()
//
//    lazy var price: UILabel = {
//
//        let lbl = UILabel(frame: CGRect(x: self.carImage.frame.width + 100, y: 46, width: self.contentView.frame.width - 130, height: 30))
//        lbl.textAlignment = .right
//        lbl.font = UIFont(name: "Arial", size: 12)
//        //lbl.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
//        lbl.textColor = .red
//
//        return lbl
//    }()
//
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        addSubview(carImage)
//        addSubview(title)
//        addSubview(location)
//        addSubview(price)
//
//    }
    
}

