//
//  DependinatorTests.swift
//  DependinatorTests
//
//  Created by Rod Schmidt on 1/30/17.
//  Copyright © 2017 infiniteNIL. All rights reserved.
//

import Quick
import Nimble

@testable import Dependinator

class DependinatorSpecs: QuickSpec {

    override func spec() {
        var sut: DetailViewController!
        let webServiceMock = WebServiceMock()
        
        beforeEach {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            sut = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
            sut.webService = webServiceMock
            XCTAssertNotNil(sut.view)  // load the view
        }

        describe("view setup") {
            it("has an activityIndicator") {
                expect(sut.activityIndicator) != nil //.toNot(beNil())
            }

            it("has a detail description label") {
                expect(sut.detailDescriptionLabel) != nil //.toNot(beNil())
            }

            it("should load the resource") {
                expect(webServiceMock.getDateCalled) == true
            }
        }

        describe("activity indicator") {
            it("stops the activityIndicator") {
                expect(sut.activityIndicator.isAnimating).toEventually(beFalse())
            }
        }

        describe("loading") {
            it("loads the data") {
                expect(sut.detailItem).toEventuallyNot(beNil())
            }

            it ("shows the detail label") {
                expect(sut.detailDescriptionLabel.isHidden).toEventuallyNot(beTrue())
            }

            it("sets the label") {
                expect(sut.detailDescriptionLabel.text).toEventuallyNot(beNil())
            }
        }
    }

}

class WebServiceMock: WebService {

    private(set) var getDateCalled = false

    override func getDate(completionHandler: @escaping (Result<Date>) -> Void) {
        getDateCalled = true
        completionHandler(.success(Date()))
    }

}
