//
//  LocationPreviewView.swift
//  mapapp
//
//  Created by Map Mac on 12/10/2023.
//

import SwiftUI

struct LocationPreviewView: View {
    
    @EnvironmentObject private var locationVM: LocationsViewModel
    let location: Location
    
    var body: some View {
        HStack (alignment: .bottom, spacing: 0) {
            VStack(alignment: .leading, spacing: 16) {
                imageSection
                titleSection
            }
            
            buttonSection
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThinMaterial)
                .offset(x: 0.0, y: 65)
        )
        .cornerRadius(10)
    }
}

#Preview {
    ZStack {
        
        Color.yellow
            .ignoresSafeArea()
        
        LocationPreviewView(location: LocationsDataService.locations.first!)
            .padding(.horizontal)
            .environmentObject(LocationsViewModel())
    }
}

extension LocationPreviewView {
    private var imageSection: some View {
        ZStack {
            if let imageName = location.imageNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
            }
            
        }
        .padding(6)
        .background(Color.white)
        .cornerRadius(10)
    }
    
    private var titleSection: some View {
        VStack (alignment: .leading, spacing: 4) {
            Text(location.name)
                .font(.title2)
                .fontWeight(.bold)
            
            Text(location.cityName)
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var buttonSection: some View {
        VStack {
            learnMoreButton
            nextButton
        }
    }
    
    private var learnMoreButton: some View {
            Button(action: {
                locationVM.sheetLocation = location
            }, label: {
                Text("Learn more")
                    .font(.headline)
                    .frame(width: 125, height: 35)
            })
            .buttonStyle(.borderedProminent)
    }
    
    private var nextButton: some View {
            Button(action: {
                locationVM.selectNextLocation()
            }, label: {
                Text("Next")
                    .font(.headline)
                    .frame(width: 125, height: 35)
            })
            .buttonStyle(.bordered)
    }
}
