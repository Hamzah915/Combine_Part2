//
//  PlanetsViewModel.swift
//  CombineSwiftUI
//
//  Created by Hamzah Azam on 05/05/2023.
//

import Foundation
import Combine

class PlanetsViewModel: ObservableObject{
    @Published var planetsList:[Planets] = []
    @Published var filteredPlanetsList:[Planets] = []
    @Published var customError : NetworkErrorEnum?

    @Published var networkErrorEnum:NetworkErrorEnum?
    
    let networkableProtocol: NetworkableProtocol
    private var cancelable = Set<AnyCancellable>()

    init(networkableProtocol: NetworkableProtocol) {
        self.networkableProtocol = networkableProtocol
    }
    
    
    
    func getPlanetsList(apiUrl:String){
        guard let url = URL(string: apiUrl) else{
            return
        }
        self.networkableProtocol.getDataFromApi(url: url, type: Planetinfo.self)
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion{
                    
                case .finished:
                    print("Finished")
                case .failure(let error):
                    switch error{
                    case let decodingError as DecodingError:
                        self.networkErrorEnum = .parsingError
                    case let apiError as NetworkErrorEnum:
                        self.networkErrorEnum = .invalidUrlError
                    default:
                        self.networkErrorEnum = .dataNotFoundError
                    }
                    print(self.networkErrorEnum?.localizedDescription)
                }
            }receiveValue: { planetsArr in
                print(planetsArr)
                self.planetsList = planetsArr.results
                self.filteredPlanetsList = planetsArr.results.sorted(by: {$0.name < $1.name})
            }.store(in: &cancelable)
    }
    
    func searchListOfUsers(searchTerm:String){
        if searchTerm.isEmpty{
            self.filteredPlanetsList = self.planetsList.sorted(by: {$0.name < $1.name})
        }else{
            let filteredList = self.planetsList.filter { planets in
                return planets.name.contains(searchTerm)
            }
            self.filteredPlanetsList = filteredList.sorted(by: {$0.name < $1.name})
        }
    }
    
    func cancelAPIRequest(){
        print("Cancel API Request")
        cancelable.first?.cancel()
    }
}
