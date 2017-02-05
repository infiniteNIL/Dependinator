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
        }

        describe("view setup") {
            beforeEach { _ = sut.view }

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
            beforeEach { _ = sut.view }
            
            it("stops the activityIndicator") {
                expect(sut.activityIndicator.isAnimating).toEventually(beFalse())
            }
        }

        describe("loading") {
            context("when successful") {
                beforeEach {
                    webServiceMock.getDateResult = .success(self.makeTestDate())
                    _ = sut.view
                }

                it("loads the data") {
                    expect(sut.detailItem).toEventuallyNot(beNil())
                }

                it ("shows the detail label") {
                    expect(sut.detailDescriptionLabel.isHidden).toEventuallyNot(beTrue())
                }

                it("sets the label") {
                    expect(sut.detailDescriptionLabel.text).toEventuallyNot(beNil())
                }

                it("sets the label to the right value") {
                    expect(sut.detailDescriptionLabel.text).toEventually(equal("2017-03-07 00:00:00 +0000"))
                }
            }

            context("when there are errors") {
                beforeEach {
                    webServiceMock.getDateResult = .failure("Unable to load date")
                    _ = sut.view
                }

                it("should keep the detail label hidden") {
                    expect(sut.detailDescriptionLabel.isHidden) == true
                }

                it("should stop the activity indicator") {
                    expect(sut.activityIndicator.isAnimating) == false
                }
            }
        }
    }

    func makeTestDate() -> Date {
        var components = DateComponents()
        components.year = 2017
        components.month = 3
        components.day = 7
        components.hour = 0
        components.minute = 0
        components.second = 0
        components.timeZone = TimeZone(secondsFromGMT: 0)
        return Calendar.current.date(from: components)!
    }

}

class WebServiceMock: WebService {

    private(set) var getDateCalled = false
    var getDateResult: Result<Date> = .success(Date())

    override func getDate(completionHandler: @escaping (Result<Date>) -> Void) {
        getDateCalled = true
        completionHandler(getDateResult)
    }

}
