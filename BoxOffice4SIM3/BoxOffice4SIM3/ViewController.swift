//
//  ViewController.swift
//  BoxOffice4SIM3
//
//  Created by Mac-Mini-2021 on 13/2/2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    var data = [
        "El Camino",
        "Extraction",
        "Project Power",
        "Six Underground",
        "Spenser Confidential",
        "The Irishman"
    ]
    @IBOutlet weak var movieCell: UITableViewCell!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "moviesTV", for: indexPath)
        
        let movieName = cell.viewWithTag(2) as! UILabel
        let moviePoster = cell.viewWithTag(1) as! UIImageView
        
        let movie = data[indexPath.row]
        
        movieName.text = movie
        moviePoster.image = UIImage(named: movie)
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

