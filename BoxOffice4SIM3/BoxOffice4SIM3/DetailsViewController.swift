//
//  DetailsViewController.swift
//  BoxOffice4SIM3
//
//  Created by Mac-Mini-2021 on 16/2/2023.
//

import UIKit
import CoreData

class DetailsViewController: UIViewController {
    
    
    @IBOutlet weak var movieArt: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var favsButton: UIButton!
    
    var name: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        movieTitle.text = name!
        movieArt.image=UIImage(named: name!)
        
        if checkIfExists() {
            favsButton.isEnabled = false
        }
        
    }
    
    @IBAction func addToFavsAction(_ sender: Any) {
        showAlert(title: "Alert", message: "Do you want to add this movie to your favorites?", okHandler: {_  in self.save()})
    }
    
    
    func showAlert(title: String, message: String, okHandler: ((UIAlertAction) -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
                
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: okHandler))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func checkIfExists() -> Bool {
        //1
        guard let appDelegate =
          UIApplication.shared.delegate as? AppDelegate else {
            return false
        }
        
        let managedContext =
          appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
          NSFetchRequest<NSManagedObject>(entityName: "Movies")
        
        fetchRequest.predicate = NSPredicate(
            format: "name LIKE %@", name
        )
        
        do {
            let result = try managedContext.fetch(fetchRequest).first
            
            if result == nil {
                return false
            }
        }
        catch _ as NSError {
            print("Error fetching data...")
        }
        
        return true
    }
    
    func save() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
      
      // 1
      let managedContext =
        appDelegate.persistentContainer.viewContext
        
      managedContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
      
      // 2
      let entity =
        NSEntityDescription.entity(forEntityName: "Movies",
                                   in: managedContext)!
      
      let movie = NSManagedObject(entity: entity,
                                   insertInto: managedContext)
      
      // 3
        movie.setValue(name, forKeyPath: "name")
      
      // 4
      do {
        try managedContext.save()
          showToast(message: "Saved", seconds: 0.75)
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
      }
    }
    
    func showToast(message : String, seconds: Double){
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            alert.view.backgroundColor = .black
            alert.view.alpha = 0.5
            alert.view.layer.cornerRadius = 15
            self.present(alert, animated: true)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
                alert.dismiss(animated: true)
        }
    }
}
