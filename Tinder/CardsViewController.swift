//
//  ViewController.swift
//  Tinder
//
//  Created by Darrell Shi on 3/24/16.
//  Copyright © 2016 iOS Development. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    @IBOutlet weak var tinderDraggableView: DraggableView!
    var isPresenting = true
    var interactiveTransition: UIPercentDrivenInteractiveTransition!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        tinderDraggableView.imageView.image = UIImage(named: "ryan")
        var gesture = UIPinchGestureRecognizer(target: self, action:#selector(CardsViewController.onPinch(_:)))
        tinderDraggableView.addGestureRecognizer(gesture)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController as! ProfileViewController
        vc.modalPresentationStyle = UIModalPresentationStyle.Custom
        vc.transitioningDelegate = self
    }
    
    @IBAction func onTapImage(sender: AnyObject) {
        performSegueWithIdentifier("ToProfileViewController", sender: nil)
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = true
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = false
        return self
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        // The value here should be the duration of the animations scheduled in the animationTransition method
        return 0.4
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView()!
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        
        if (isPresenting) {
            containerView.addSubview(toViewController.view)
            toViewController.view.alpha = 0
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                toViewController.view.alpha = 1
            }) { (finished: Bool) -> Void in
                transitionContext.completeTransition(true)
            }
        } else {
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                fromViewController.view.alpha = 0
            }) { (finished: Bool) -> Void in
                transitionContext.completeTransition(true)
                fromViewController.view.removeFromSuperview()
            }
        }
    }
    
    func interactionControllerForPresentation(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        interactiveTransition = UIPercentDrivenInteractiveTransition()
        //Setting the completion speed gets rid of a weird bounce effect bug when transitions complete
        interactiveTransition.completionSpeed = 0.99
        return interactiveTransition
    }
    
    func onPinch(sender: UIPinchGestureRecognizer) {
        let scale = sender.scale
        let velocity = sender.velocity
        if (sender.state == UIGestureRecognizerState.Began){
            //blueSegue is the name we gave our modal segue, this also starts our interactive transition
            performSegueWithIdentifier("ToProfileViewController", sender: self)
        } else if (sender.state == UIGestureRecognizerState.Changed){
            //We are dividing by 7 here since updateInteractiveTransition expects a number between 0 and 1
            interactiveTransition.updateInteractiveTransition(scale / 7)
        } else if sender.state == UIGestureRecognizerState.Ended {
            if velocity > 0 {
                interactiveTransition.finishInteractiveTransition()
            } else {
                interactiveTransition.cancelInteractiveTransition()
            }
        }
    }
}

