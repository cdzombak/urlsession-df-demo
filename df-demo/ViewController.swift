//
//  ViewController.swift
//  df-demo
//
//  Created by Chris Dzombak on 1/20/17.
//  Copyright © 2017 Chris Dzombak. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tryFrontedRequest()
    }

    let client = DFNetworkClient()

    func tryFrontedRequest() {
        let request = URLRequest(url: URL(string: "https://df-demo-156220.appspot-preview.com/")!)

        try! client.dataTask(with: request) { (data, response, error) in
            dump(data)
            dump(response)
        }.resume()
    }
}
