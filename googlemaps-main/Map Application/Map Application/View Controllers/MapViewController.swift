//
//  MapViewController.swift
//  Map Application
//
//  Created by Shreya Chatterjee on 23/07/22.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController,CLLocationManagerDelegate {
  
    @IBOutlet private weak var mapCenterPinImage: UIImageView!
    @IBOutlet private weak var pinImageVerticalConstraint: NSLayoutConstraint!
    @IBOutlet weak var mapView: GMSMapView!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    private let locationManager = CLLocationManager()

    private let dataProvider = GoogleDataProvider()
    private let searchRadius: Double = 1000
    
    
    @IBAction func refreshPlaces(_ sender: Any) {
        fetchNearbyPlaces(coordinate: mapView.camera.target)
    }
    
    
    var searchedTypes = ["bakery", "bar", "cafe", "grocery_or_supermarket", "restaurant"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        mapView.delegate = self
        
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let navigationController = segue.destination as? UINavigationController,
      let controller = navigationController.topViewController as? TypesTableViewController else {
        return
    }
    controller.selectedTypes = searchedTypes
    controller.delegate = self
  }
    // 2 : locationManager(_:didChangeAuthorization:) is called when the user grants or revokes location permissions.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // 3 :Here you verify the user has granted you permission while the app is in use.
        guard status == .authorizedWhenInUse else {
            return
        }
        // 4 : Once permissions have been established, ask the location manager for updates on the user’s location.
        locationManager.startUpdatingLocation()
        
        //5 : GMSMapView has two features concerning the user’s location: myLocationEnabled draws a light blue dot where the user is located, while myLocationButton, when set to true, adds a button to the map that, when tapped, centers the map on the user’s location.
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    }
    
    // 6 : locationManager(_:didUpdateLocations:) executes when the location manager receives new location data.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        // 7 : This updates the map’s camera to center around the user’s current location. The GMSCameraPosition class aggregates all camera position parameters and passes them to the map for display.
        mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        
        // 8 : Tell locationManager you’re no longer interested in updates; you don’t want to follow a user around as their initial location is enough for you to work with.
        locationManager.stopUpdatingLocation()
        
        fetchNearbyPlaces(coordinate: location.coordinate)

    }
    
    private func reverseGeocodeCoordinate(_ coordinate: CLLocationCoordinate2D) {
        self.addressLabel.unlock()

        
        // 1 : Creates a GMSGeocoder object to turn a latitude and longitude coordinate into a street address.
        let geocoder = GMSGeocoder()
        
        // 2 : Asks the geocoder to reverse geocode the coordinate passed to the method. It then verifies there is an address in the response of type GMSAddress. This is a model class for addresses returned by the GMSGeocoder.
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            guard let address = response?.firstResult(), let lines = address.lines else {
                return
            }
            
            // 3 : Sets the text of the addressLabel to the address returned by the geocoder.
            self.addressLabel.text = lines.joined(separator: "\n")
            
            
            
            let labelHeight = self.addressLabel.intrinsicContentSize.height
            self.mapView.padding = UIEdgeInsets(top: self.view.safeAreaInsets.top, left: 0,
                                                bottom: labelHeight, right: 0)

            
            // 4 : Once the address is set, animate the changes in the label’s intrinsic content size.
            UIView.animate(withDuration: 0.25) {
              
              self.pinImageVerticalConstraint.constant = ((labelHeight - self.view.safeAreaInsets.top) * 0.5)
              self.view.layoutIfNeeded()
            }

        }
    }
    
    private func fetchNearbyPlaces(coordinate: CLLocationCoordinate2D) {
      // 1
      mapView.clear()
      // 2
      dataProvider.fetchPlacesNearCoordinate(coordinate, radius:searchRadius, types: searchedTypes)
        {//o value in places
            places in
        places.forEach {
            //this is section is not working
          // 3
          let marker = PlaceMarker(place: $0)
          // 4
          marker.map = self.mapView
        }
      }
    }

}

// MARK: - TypesTableViewControllerDelegate
extension MapViewController: TypesTableViewControllerDelegate {
    func typesController(_ controller: TypesTableViewController, didSelectTypes types: [String]) {
        searchedTypes = controller.selectedTypes.sorted()
        dismiss(animated: true)
        
        fetchNearbyPlaces(coordinate: mapView.camera.target)

    }
}



extension MapViewController : GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
      reverseGeocodeCoordinate(position.target)
    }
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        addressLabel.lock()
        if (gesture) {
            mapCenterPinImage.fadeIn(0.25)
            mapView.selectedMarker = nil
        }

    }
    func mapView(_ mapView: GMSMapView, markerInfoContents marker: GMSMarker) -> UIView? {
      // 1
      guard let placeMarker = marker as? PlaceMarker else {
        return nil
      }
        
      // 2
      guard let infoView = UIView.viewFromNibName("MarkerInfoView") as? MarkerInfoView else {
        return nil
      }
        
      // 3
      infoView.nameLabel.text = placeMarker.place.name
        
      // 4
      if let photo = placeMarker.place.photo {
        infoView.placePhoto.image = photo
      } else {
        infoView.placePhoto.image = UIImage(named: "generic")
      }
        
      return infoView
    }
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
      mapCenterPinImage.fadeOut(0.25)
      return false
    }
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
      mapCenterPinImage.fadeIn(0.25)
      mapView.selectedMarker = nil
      return false
    }

}
