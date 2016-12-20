//
//  ViewController.swift
//  iFace
//
//  Created by Niu Panfeng on 20/12/2016.
//  Copyright © 2016 NaPaFeng. All rights reserved.
//

import UIKit

class FaceViewController: UIViewController, FaceViewDataSource {
    
    //数据源指向自己
    @IBOutlet weak var faceView: FaceView! {
        didSet {
            faceView.dataSource = self
            //缩放
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: "scale:"))
            //滑动
            //faceView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "changeHappiness:"))
        }
    }

    var happiness: Int  = 0 { //0=very sad, 100=ecstatic
        didSet{
            happiness = min(max(happiness,0),100)
            print("happiness = \(happiness)")
            updateUI()
        }
    }
    func updateUI() {
        faceView.setNeedsDisplay()
    }
    
    private struct Constants {
        static let HappinessGestureScale: CGFloat = 4 //移动4个点，happiness变化1
    }
    
    @IBAction func changeHappiness(gesture: UIPanGestureRecognizer) {
        switch gesture.state
        {
        case .Ended:
            fallthrough
        case .Changed:
            let translation = gesture.translationInView(faceView)
            let happinessChange = Int(translation.y / Constants.HappinessGestureScale)
            if happinessChange != 0 {
                happiness += happinessChange
                gesture.setTranslation(CGPointZero, inView: faceView)
            }
        default:
            break
        }
    }
    
    /*
    func changeHappiness(gesture: UIPanGestureRecognizer) {
        switch gesture.state
        {
        case .Ended:
            fallthrough
        case .Changed:
            let translation = gesture.translationInView(faceView)
            let happinessChange = Int(translation.y / Constants.HappinessGestureScale)
            if happinessChange != 0 {
                happiness += happinessChange
                gesture.setTranslation(CGPointZero, inView: faceView)
            }
        default:
            break
        }
    }*/
    /** FaceViewDataSource */
    func smilinessForFaceView(sender: FaceView) -> Double? {
        return Double(happiness - 50) / 50
    }
}

