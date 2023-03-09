//
//  FavoritesViewController.swift
//  BoxOffice4SIM3
//
//  Created by Mac-Mini-2021 on 23/2/2023.
//

import UIKit
import CoreData

class FavoritesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate  {
    
    var movies: [Movie] = []
    
    @IBOutlet weak var favsCol: UICollectionView!
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favCell", for: indexPath)
        let contentView = cell.viewWithTag(0)
        let image = contentView?.viewWithTag(1) as! UIImageView
        let movieName = contentView?.viewWithTag(2) as! UILabel
        
        let movie = movies[indexPath.row]
        
        movieName.text = movie.Title
       // image.image = UIImage(named: movie.Title)
        
        let delSwipe = UISwipeGestureRecognizer(target: self, action: #selector(delAction))
        
        delSwipe.direction = UISwipeGestureRecognizer.Direction.right
        
        cell.addGestureRecognizer(delSwipe)
        
        return cell
    }
    
    @objc private func delAction(sender: UISwipeGestureRecognizer) {
        let cell = sender.view as! UICollectionViewCell
        let itemIndex = self.favsCol!.indexPath(for: cell)!.item
        
        let removed = movies[itemIndex]
        
        movies.remove(at: itemIndex)
        
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
        
        fetchRequest.predicate = NSPredicate(
            format: "title LIKE %@", removed.Title
        )
        
        do {
            let result = try managedContext.fetch(fetchRequest).first
            
            if result != nil {
                
                managedContext.delete(result!)
            }
        }
        catch _ as NSError {
            print("Error fetching data...")
        }
        self.favsCol.reloadData()
    }

    override func viewDidLoad() {
      super.viewDidLoad()
      
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
              let movie = Movie(Title: data.value(forKey: "title") as! String,
                                Year: data.value(forKey: "year") as! String,
                                Runtime: data.value(forKey: "runtime") as! String,
                                Poster: data.value(forKey: "poster") as! String
                                )
              movies.append(movie)
         }
          
      } catch let error as NSError {
        print("Could not fetch. \(error), \(error.userInfo)")
      }
    }
}
