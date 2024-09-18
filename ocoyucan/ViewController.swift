import UIKit
import SwiftUI
import MapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

struct ContentView: View {
    @State private var cameraPosition = MapCameraPosition.region(MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude:  18.944816, longitude: -98.330554),
            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        ))
     
    var body: some View {
        Map(position: $cameraPosition)
            .frame(width: 358, height: 510)
    }
}

