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
        
        beforeEach {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            sut = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
            UIApplication.shared.keyWindow!.rootViewController = sut
            XCTAssertNotNil(sut.view)  // load the view
        }

        describe("view setup") {
            it("has an activityIndicator") {
                expect(sut.activityIndicator) != nil //.toNot(beNil())
            }

            it("has a detail description label") {
                expect(sut.detailDescriptionLabel) != nil //.toNot(beNil())
            }

            it("has no data") {
                expect(sut.detailItem).to(beNil())
            }
        }

        describe("activity indicator") {
            beforeEach { sut.viewDidLoad() }

            it("shows activity on load") {
                expect(sut.activityIndicator.isAnimating) == true //.to(equal(true))
            }

            it("stops the activityIndicator") {
                expect(sut.activityIndicator.isAnimating).toEventually(beFalse(), timeout: 5.5)
            }
        }

        describe("loading") {
            beforeEach { sut.viewDidLoad() }

            it("loads the data") {
                expect(sut.detailItem).toEventuallyNot(beNil(), timeout: 5.5)
            }

            it ("shows the detail label") {
                expect(sut.detailDescriptionLabel.isHidden).toEventuallyNot(beTrue(), timeout: 5.5)
            }

            it("sets the label") {
                expect(sut.detailDescriptionLabel.text).toEventuallyNot(beNil(), timeout: 5.5)
            }
        }
    }

}
