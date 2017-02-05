//
//  DetailViewController.swift
//  Dependinator
//
//  Created by Rod Schmidt on 1/30/17.
//  Copyright © 2017 infiniteNIL. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    private let webService = WebService()

    private(set) var detailItem: Date? {
        didSet {
            configureView()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchResource()
    }

    private func fetchResource() {
        activityIndicator.startAnimating()

        webService.getDate { result in
            self.activityIndicator.stopAnimating()

            switch result {
                case .success(let date):
                    self.detailItem = date

                case .failure(let error):
                    print(error)
            }
        }
    }

    private func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem,
            let label = self.detailDescriptionLabel {
            label.isHidden = false
            label.text = detail.description
        }
    }

}

