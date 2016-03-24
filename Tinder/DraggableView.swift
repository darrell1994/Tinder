//
//  DraggableView.swift
//  Tinder
//
//  Created by Darrell Shi on 3/24/16.
//  Copyright © 2016 iOS Development. All rights reserved.
//

import UIKit

class DraggableView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    func initSubviews() {
        // standard initialization logic
        let nib = UINib(nibName: "DraggableView", bundle: nil)
        nib.instantiateWithOwner(self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
            
        // custom initialization logic
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(DraggableView.onDraggingImage(_:)))
        imageView.addGestureRecognizer(gesture)
    }

    var image: UIImage? {
        get { return imageView.image }
        set { imageView.image = newValue }
    }
    
    var originalCenter: CGPoint?
    func onDraggingImage(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translationInView(self)

        if gesture.state == .Began {
            originalCenter = imageView.center
        } else if gesture.state == .Changed {
            imageView.center = CGPoint(x: originalCenter!.x+translation.x, y: originalCenter!.y)
            imageView.transform = CGAffineTransformMakeRotation(CGFloat(Double(translation.x)/180.0*M_PI)/6)
        } else if gesture.state == .Ended {
            if translation.x > 50 {
                UIView.animateWithDuration(0.35, animations: {
                    self.imageView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI/2))
                    self.imageView.center = CGPoint(x: UIScreen.mainScreen().bounds.width+200, y: self.originalCenter!.y)
                })
            } else if translation.x < -50 {
                UIView.animateWithDuration(0.35, animations: {
                    self.imageView.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI/2))
                    self.imageView.center = CGPoint(x: -200, y: self.originalCenter!.y)
                })
            } else {
                imageView.transform = CGAffineTransformIdentity
            }
        }
    }
}
