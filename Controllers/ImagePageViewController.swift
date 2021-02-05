//
//  ImagePageViewController.swift
//  ArabamAssignment
//
//  Created by Batuhan Baran on 2.02.2021.
//

import UIKit
import SDWebImage
import ImageSlideshow

class ImagePageViewController: UIViewController {
    

    @IBOutlet var imageSlideShow: ImageSlideshow!
    var imageSources = [SDWebImageSource]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButton))
        
        imageSlideShow.contentScaleMode = .scaleAspectFit
        
        if let imageUrls = UserDefaults.standard.array(forKey: "imageUrls") as? [String]{
            
            for imageUrl in imageUrls{
                
                self.imageSources.append(SDWebImageSource(urlString: imageUrl.replacingOccurrences(of: "{0}", with: "800x600"))!)
            }
            
            self.imageSlideShow.setImageInputs(self.imageSources)
        }
        
    }
    
    @objc func doneButton(){
        
        self.dismiss(animated: true, completion: nil)
    }


}
