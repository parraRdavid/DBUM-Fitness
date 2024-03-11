//
//  searchGymView.swift
//  Dbum-Fitness
//
//  Created by iMac on 11/10/23.
//

import CoreLocation
import MapKit
import SwiftUI


struct searchGymView: View {
    
    
    @State private var startLocationText = ""
    @State private var endLocationText = ""
    
    @State private var startLocation: Placemark?
    @State private var endLocation: Placemark?
    
    var body: some View {
        VStack {
            
            Text("Find a Gym !")
                .font(Font.custom("AppleGothic", fixedSize: 40))
                .tracking(4)
                .bold()

            VStack(spacing: 50) {
                
                Text("Enter Your Current Location")
                    .font(Font.custom("AppleGothic", fixedSize: 30))
                    .tracking(4)
                
                Text("To test use your home address.")
                    .font(.custom("AppleGothic", fixedSize: 15))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                TextField("", text: $startLocationText)
                    .textFieldStyle(TextFieldBorder())
                
                Text("Enter Your Gym Location")
                    .font(Font.custom("AppleGothic", fixedSize: 30))
                    .tracking(4)
                
                
                Text("To test use: 5070 N 83rd Ave, Glendale, AZ 85305")
                    .font(.custom("AppleGothic", fixedSize: 15))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                TextField("", text: $endLocationText)
                    .textFieldStyle(TextFieldBorder())
            }
            
            .padding(10)
            
            Button {
                startLocation = nil
                endLocation = nil
                
                forwardGeocoding(address: startLocationText) {
                    startLocation = $0
                    openMaps()
                }
                
                forwardGeocoding(address: endLocationText) {
                    endLocation = $0
                    openMaps()
                }
                
            } label: {
                HStack {
                    Text("Go Search")
                        .fontWeight(.semibold)
                        .font(Font.custom("AppleGothic", fixedSize: 18))
                    
                    Image(systemName: "location.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .padding(.trailing, 8)
                }
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 50, height: 48)
            }
            .background(Color.indigo)
            .cornerRadius(10)
            .padding(.top, 24)
        }//end main vstack
    }//end body
    
    
    
    
    func forwardGeocoding(
        address: String,
        completionHandler: @escaping (Placemark) -> Void
    ) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { placemarks, error in
            guard error == nil else {
                print("Failed to retrieve location")
                return
            }
            guard
                let placemarks = placemarks,
                placemarks.count > 0,
                let first = placemarks.first,
                let name = first.name,
                let location = first.location
            else {
                print("No Matching Location Found")
                return
            }
            
            let placemark = Placemark(name: name, coordinate: location.coordinate)
            completionHandler(placemark)
        }
    }
    
    
    func openMaps() {
        guard let start = startLocation, let end = endLocation else {
            return
        }
        
        let source = MKMapItem(
            placemark: MKPlacemark(coordinate: start.coordinate)
        )
        source.name = start.name
        let destination = MKMapItem(
            placemark: MKPlacemark(coordinate: end.coordinate)
        )
        destination.name = end.name
        
        MKMapItem.openMaps(
            with: [source, destination],
            launchOptions: [
                MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving
            ]
        )
    }
}

struct Placemark {
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct searchGymView_Previews: PreviewProvider {
    static var previews: some View {
        searchGymView()
    }
}
