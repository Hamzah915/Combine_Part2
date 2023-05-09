//
//  PlanetsListView.swift
//  CombineSwiftUI
//
//  Created by Hamzah Azam on 05/05/2023.
//

import SwiftUI
import Combine

struct PlanetsListView: View {
    @StateObject var planetsViewModel = PlanetsViewModel(networkableProtocol: NetworkManager())
    @State private var searchTerm = ""
    
    var body: some View{
        NavigationStack{
            VStack{
                Button("Cancel ongoing request"){
                    planetsViewModel.cancelAPIRequest()
                }
                List(planetsViewModel.filteredPlanetsList){ planet in
                    VStack{
                        Text(planet.name)
                        Text(planet.climate)
                    }
                }
            }.onAppear(){
                planetsViewModel.getPlanetsList(apiUrl: APIEndPoint.planetsListEndPoint)
            }.searchable(text: $searchTerm, placement: .navigationBarDrawer(displayMode: .always)).onChange(of: searchTerm) { newSearch in
                planetsViewModel.searchListOfUsers(searchTerm: newSearch)
            }
            
        }.padding()
    }
    
}

struct PlanetsListView_Previews: PreviewProvider {
    static var previews: some View {
        PlanetsListView()
    }
}
