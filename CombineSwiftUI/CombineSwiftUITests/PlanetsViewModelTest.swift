//
//  PlanetsViewModelTest.swift
//  CombineSwiftUITests
//
//  Created by Hamzah Azam on 08/05/2023.
//

import XCTest
@testable import CombineSwiftUI

final class PlanetsViewModelTest: XCTestCase {
    
    var planetsViewModel : PlanetsViewModel!

    override func setUpWithError() throws {
        planetsViewModel = PlanetsViewModel(networkableProtocol: FakeNetworkManager())
    }

    override func tearDownWithError() throws {
        planetsViewModel = nil
    }
    
    func testGetPlanetsList_everything_works() throws{
        planetsViewModel.getPlanetsList(apiUrl: "PlanetsList")
        
        let expectation = XCTestExpectation(description: "getPlanetsList function gets called as everything works")
        let waitDuration = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + waitDuration){
            XCTAssertNotNil(self.planetsViewModel)
            XCTAssertEqual(self.planetsViewModel.filteredPlanetsList.count, 0)
            XCTAssertNil(self.planetsViewModel.customError)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: waitDuration)
    }
    
    func testApiCallWithEmptyJSONFile() throws {
           
           planetsViewModel.getPlanetsList(apiUrl: "PlanetsListEmpty")
           
           let expectation = XCTestExpectation(description: "The url is valid but there is no data shown")
           let waitDuration = 2.0
           DispatchQueue.main.asyncAfter(deadline: .now() + waitDuration){
               XCTAssertNotNil(self.planetsViewModel)
               XCTAssertEqual(self.planetsViewModel.filteredPlanetsList.count, 0)
               XCTAssertEqual(self.planetsViewModel.customError, NetworkErrorEnum.dataNotFoundError)
               expectation.fulfill()
           }
           
           wait(for: [expectation], timeout: waitDuration)
           
       }
       
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
