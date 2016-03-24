//
//  ViewController.swift
//  Tinder
//
//  Created by Darrell Shi on 3/24/16.
//  Copyright © 2016 iOS Development. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {
    @IBOutlet weak var tinderDraggableView: DraggableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        tinderDraggableView.imageView.image = UIImage(named: "ryan")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

