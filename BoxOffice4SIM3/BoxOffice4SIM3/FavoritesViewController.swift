//
//  FavoritesViewController.swift
//  BoxOffice4SIM3
//
//  Created by Mac-Mini-2021 on 23/2/2023.
//

import UIKit
import CoreData

class FavoritesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate  {
    
    var movies: [String] = []
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favCell", for: indexPath)
        let contentView = cell.viewWithTag(0)
        let image = contentView?.viewWithTag(1) as! UIImageView
        let movieName = contentView?.viewWithTag(2) as! UILabel
        
        let name = movies[indexPath.row]
        
        movieName.text = name
        image.image = UIImage(named: name)
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      
      //1
      guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
          return
      }
      
      let managedContext =
        appDelegate.persistentContainer.viewContext
      
      //2
      let fetchRequest =
        NSFetchRequest<NSManagedObject>(entityName: "Movies")
      
      //3
      do {
          
          for data in try managedContext.fetch(fetchRequest) {
              movies.append(data.value(forKey: "name") as! String)
         }
          
      } catch let error as NSError {
        print("Could not fetch. \(error), \(error.userInfo)")
      }
    }



}
