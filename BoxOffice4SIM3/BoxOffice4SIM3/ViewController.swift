//
//  ViewController.swift
//  BoxOffice4SIM3
//
//  Created by Mac-Mini-2021 on 13/2/2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var data = [
        "El Camino",
        "Extraction",
        "Project Power",
        "Six Underground",
        "Spenser Confidential",
        "The Irishman"
    ]
    
    var moviesL: [Movie] = []
    
    let DETAILS_SEGUE = "detailSeg"
    let FAVORITES_SEGUE = "favSeg"
    
    @IBAction func goToFavorites(_ sender: Any) {
        performSegue(withIdentifier: FAVORITES_SEGUE, sender: sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesL.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: DETAILS_SEGUE, sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == DETAILS_SEGUE {
        
        let dest = segue.destination as! DetailsViewController
        
        let index = sender as! IndexPath
        
        dest.name = moviesL[index.row]
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "moviesTV",for: indexPath)
        
        let cv = cell.contentView
        
        let movieName = cv.viewWithTag(2) as! UILabel
        let moviePoster = cv.viewWithTag(1) as! UIImageView
        
        let movie = data[indexPath.row]
        
        movieName.text = movie
        moviePoster.image = UIImage(named: movie)

        return cell
    }
}

