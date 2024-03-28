//
//  ContentView.swift
//  Akintoye_Final
//
//  Created by Arogs on 3/12/24.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var coreDBHelper : CoreDBHelper
    @EnvironmentObject var locationHelper: LocationHelper

    
    var body: some View {
        NavigationStack{
            ZStack(alignment: .bottom){
                List{
                    ForEach(self.coreDBHelper.restaurantList.enumerated().map({$0}), id: \.element.self){index, currentRestaurant in
                        
                        NavigationLink(destination: RestaurantMapView(restaurant: currentRestaurant, selectedRestaurantIndex: index)){
                            VStack(alignment: .leading){
                                Text(currentRestaurant.restaurant!)
                                    .fontWeight(.bold)
                                
                            }//VStack
                        }//NavigationLink
                    }//ForEach
                }//List ends
              
                            }
            
            .navigationTitle("Favourite Restaurants").navigationBarTitleDisplayMode(.inline)
        }
        .onAppear(){
//            self.coreDBHelper.insertRestaurant(newRestaurant: Restaurant("Green Basil", 43.67194509399123, 79.29481045076973))
//            self.coreDBHelper.insertRestaurant(newRestaurant: Restaurant("Garden State Restaurant", 43.67328970467347, 79.28743641138487))
//            self.coreDBHelper.insertRestaurant(newRestaurant: Restaurant("ViVetha Bistro", 43.67445500956285, 79.28192137352565))
//            self.coreDBHelper.insertRestaurant(newRestaurant: Restaurant("La Sala Restaurant", 43.67055563130399, 79.30038745534648))
//            self.coreDBHelper.insertRestaurant(newRestaurant: Restaurant("Moti Mahal", 43.672931144770516, 79.3225715402185))
//            self.coreDBHelper.insertRestaurant(newRestaurant: Restaurant("Uncle Betty's Diner", 43.71525069234152, 79.40050585666548))
            self.coreDBHelper.getAllRestaurants()
        }
    }
}

#Preview {
    HomeView()
}
