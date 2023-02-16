//
//  DetailsViewController.swift
//  BoxOffice4SIM3
//
//  Created by Mac-Mini-2021 on 16/2/2023.
//

import UIKit

class DetailsViewController: UIViewController {
    
    
    @IBOutlet weak var movieArt: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    
    var name: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        movieTitle.text = name!
        movieArt.image=UIImage(named: name!)
        
    }
    
    @IBAction func addToFavsAction(_ sender: Any) {
    }
}
