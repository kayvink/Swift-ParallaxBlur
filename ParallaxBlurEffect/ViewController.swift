//
//  ViewController.swift
//  ParallaxBlurEffect
//
//  Created by Kay Vink on 20/01/15.
//  Copyright (c) 2015 Kay Vink. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    var bgScrollView: UIScrollView?
    var contentScrollView: UIScrollView?
    var bgNoBlurView: UIImageView?
    var bgBlurView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        println(view.bounds.height)
        bgScrollView = UIScrollView(frame: CGRectMake(0,0, view.bounds.width, view.bounds.height))
        bgScrollView?.alwaysBounceVertical   = false
        bgScrollView?.userInteractionEnabled = false
        
        let square   = UIView(frame: CGRectMake(25,600, 325, 200))
        square.alpha = 0.6
        square.backgroundColor = UIColor.blackColor()

        
        let text             = UITextView(frame: CGRectMake(50,625, 275, 175))
        text.font            = UIFont(name: "Helvetica Neue", size: CGFloat(15))
        text.textColor       = UIColor.whiteColor()
        text.backgroundColor = nil
        text.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent commodo et justo vel porta. In fermentum tortor neque, sed sodales sapien pretium id. Donec suscipit eros nisi. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent commodo et justo vel porta."
        
        let bgNoBlur = UIImage(named: "bgNoBlur")
        let bgBlur   = UIImage(named: "bgBlur")
        
        bgNoBlurView        = UIImageView(image: bgNoBlur)
        bgNoBlurView?.frame = CGRectMake(0, 0, view.bounds.width, 867)
        bgBlurView          = UIImageView(image: bgBlur)
        bgBlurView?.frame   = CGRectMake(0, 0, view.bounds.width, 867)
        bgBlurView?.alpha   = 0
        
        contentScrollView = UIScrollView(frame: CGRectMake(0,0, view.bounds.width, view.bounds.height))
        contentScrollView?.alwaysBounceVertical = false
        contentScrollView?.addSubview(square)
        contentScrollView?.addSubview(text)
        contentScrollView?.contentSize = bgBlurView!.frame.size
        contentScrollView?.delegate    = self

        
        bgScrollView?.addSubview(bgNoBlurView!)
        bgScrollView?.addSubview(bgBlurView!)
        bgScrollView?.contentSize = bgBlurView!.frame.size
        
        view.addSubview(bgScrollView!)
        view.addSubview(contentScrollView!)
        view.backgroundColor = UIColor.whiteColor()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        println("draggin")
        println(self.contentScrollView?.contentOffset)
        parallaxScroll()
        updateBlur()
    }
    
    func updateBlur() {
        var offset = CGFloat(self.contentScrollView!.contentOffset.y/200)
        if(self.contentScrollView?.contentOffset.y <= 0){
            self.bgBlurView?.alpha = 0
            println(self.contentScrollView?.frame)
        } else if (self.contentScrollView?.contentOffset.y >= 200) {
            self.bgBlurView?.alpha = 1
        } else {
            self.bgBlurView?.alpha = 0 + offset

        }
    }
    
    func parallaxScroll() {
        println("content: \(contentScrollView!.contentOffset.y)")
        println("scroll: \(bgScrollView!.contentOffset.y)")

        bgScrollView?.setContentOffset(CGPointMake(contentScrollView!.contentOffset.x,
                      contentScrollView!.contentOffset.y * 0.5), animated: false)
    }

}

