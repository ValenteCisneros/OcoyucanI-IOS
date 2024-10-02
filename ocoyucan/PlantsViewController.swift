import UIKit
import SwiftUI
import MapKit

class PlantsViewController: UIViewController {
    
    let plantNames = ["Hortensia", "Cactus", "Aloe Vera", "Fern", "Snake Plant", "Peace Lily", "Pothos", "Spider Plant", "Cacti"]

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
    }
}


extension PlantsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return plantNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "plantCell", for: indexPath) as! PlantCollectionViewCell
        cell.imageView.image = UIImage(named: "plantamarilla")
        cell.nameLbl.text = plantNames[indexPath.row]
        return cell
        
    }
    
    
}

