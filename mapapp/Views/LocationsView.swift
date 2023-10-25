//
//  LocationsView.swift
//  mapapp
//
//  Created by Map Mac on 12/10/2023.
//

import SwiftUI
import MapKit

struct LocationsView: View {
    
    @EnvironmentObject private var locationsVM: LocationsViewModel
    let maxWidthForIpad: CGFloat = 700
    
    var body: some View {
        ZStack {
            mapLayer
                .ignoresSafeArea()
            
            VStack {
                header
                    .padding()
                    .frame(maxWidth: maxWidthForIpad)
                
                Spacer()
                
                locationsPreviewStack
            }
        }
        .sheet(item: $locationsVM.sheetLocation, onDismiss: nil) { location in
            LocationDetailView(location: location)
        }
    }
}

#Preview {
    LocationsView()
        .environmentObject(LocationsViewModel())
}

extension LocationsView  {
    private var header: some View {
        VStack (spacing: 0) {
            
            Button(action: {
                locationsVM.toggleLocationsList()
            }, label: {
                Text(locationsVM.mapLocation.name + " " + locationsVM.mapLocation.cityName)
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundColor(.primary)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .overlay (alignment: .leading) {
                        Image(systemName: "arrow.down")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding()
                            .rotationEffect(Angle(degrees: locationsVM.showLocationsList ? 180 : 0))
                    }
            })
            
            if (locationsVM.showLocationsList) {
                LocationsListView()
            }
        }
        .background(.thickMaterial)
        .cornerRadius(10)
        .shadow(
            color: .black.opacity(0.3),
            radius: 20,
            x: 0.0,
            y: 15
        )
        .padding()
    }
    
    
    private var mapLayer: some View {
        Map (
            coordinateRegion: $locationsVM.mapRegion,
            annotationItems: locationsVM.locations,
            annotationContent: {location in
                MapAnnotation(coordinate: location.coordinates) {
                    LocationMapAnnotationView()
                        .scaleEffect(locationsVM.mapLocation == location ? 1 : 0.7)
                        .shadow(radius: 10)
                        .onTapGesture {
                            locationsVM.showNextLocation(location: location)
                        }
                }
            }
        )
    }
    
    private var locationsPreviewStack: some View {
        ZStack {
            ForEach(locationsVM.locations) { location in
                if locationsVM.mapLocation == location {
                    LocationPreviewView(location: location)
                        .shadow(color: .black.opacity(0.3), radius: 20)
                        .padding()
                        .frame(maxWidth: maxWidthForIpad)
                        .frame(maxWidth: .infinity)
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing), removal: .move(edge: .leading)
                        ))
                }
            }
        }
    }
}
