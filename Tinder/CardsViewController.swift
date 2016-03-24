//
//  ViewController.swift
//  Tinder
//
//  Created by Darrell Shi on 3/24/16.
//  Copyright © 2016 iOS Development. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {
    @IBOutlet weak var tinderImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var originalCenter: CGPoint?
    @IBAction func onDraggingImage(gesture: UIPanGestureRecognizer) {
        if gesture.state == .Began {
            originalCenter = tinderImageView.center
        } else if gesture.state == .Changed {
            let translation = gesture.translationInView(view)
            tinderImageView.center = CGPoint(x: originalCenter!.x+translation.x, y: originalCenter!.y)
        } else if gesture.state == .Ended {
            
        }
    }
}

