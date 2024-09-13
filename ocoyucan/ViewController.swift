import UIKit
import SwiftUI
import MapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Embed the SwiftUI Map inside the UIViewController
        let mapView = UIHostingController(rootView: ContentView())
        addChild(mapView)
        mapView.view.frame = view.bounds
        view.addSubview(mapView.view)
        mapView.didMove(toParent: self)
    }
}

struct ContentView: View {
    @State private var cameraPosition = MapCameraPosition.region(MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 34.011_286, longitude: -116.166_868),
            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        ))

    var body: some View {
        Map(position: $cameraPosition)
            .frame(width: 240, height: 323)
    }
}

