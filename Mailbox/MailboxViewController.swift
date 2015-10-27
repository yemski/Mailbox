//
//  MailboxViewController.swift
//  Mailbox
//
//  Created by Piers Yem on 10/20/15.
//  Copyright (c) 2015 Piers Yem. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController , UIGestureRecognizerDelegate {

    @IBOutlet weak var feedImage: UIImageView!
    @IBOutlet weak var mailscrollView: UIScrollView!
    @IBOutlet var panGesture: UIPanGestureRecognizer!
    @IBOutlet weak var singlemsgImg: UIImageView!
    @IBOutlet weak var singlemsgView: UIView!
    
    @IBOutlet weak var latericnImg: UIImageView!
    @IBOutlet weak var listicnImg: UIImageView!
    @IBOutlet weak var archiveicnImg: UIImageView!
    @IBOutlet weak var deleteicnImg: UIImageView!
    @IBOutlet weak var rescheduleImg: UIImageView!
    @IBOutlet weak var listImg: UIImageView!
    
    var initialCenter: CGPoint!
    var laterInitialFrame: CGPoint!
    var listInitialFrame: CGPoint!
    var archiveInitialFrame: CGPoint!
    var deleteInitialFrame: CGPoint!
    
    var frictionDrag: CGFloat!
    
    var originalCenter = CGPoint()
    //var deleteOnDragRelease = false
   
    
    override func viewDidLoad() {
    super.viewDidLoad()
        
    rescheduleImg.alpha = 0
    listImg.alpha = 0
        
    //mailscrollView.contentSize = feedImage.image!.size
        mailscrollView.contentSize = CGSize(width: 320, height: 1300)
        // Do any additional setup after loading the view.
        
        latericnImg.hidden = true
        listicnImg.hidden = true
        archiveicnImg.hidden = true
        deleteicnImg.hidden = true
        
        // The onCustomPan: method will be defined in Step 3 below.
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "onCustomPan:")
        
        // Attach it to a view of your choice. If it's a UIImageView, remember to enable user interaction
        singlemsgImg.addGestureRecognizer(panGestureRecognizer)
        
        initialCenter = singlemsgView.frame.origin
        laterInitialFrame = latericnImg.frame.origin
        listInitialFrame = listicnImg.frame.origin
        archiveInitialFrame = archiveicnImg.frame.origin
        deleteInitialFrame = deleteicnImg.frame.origin
        
        frictionDrag = 10
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
    func onCustomPan(panGestureRecognizer: UIPanGestureRecognizer) {
        //println("PANNNN")
        
        // Reset all Icons to be hidden
        latericnImg.hidden = true
        listicnImg.hidden = true
        archiveicnImg.hidden = true
        deleteicnImg.hidden = true
        
        // Absolute (x,y) coordinates in parent view
        let point = panGestureRecognizer.locationInView(view)
        
        // Relative change in (x,y) coordinates from where gesture began.
        var translation = panGestureRecognizer.translationInView(view)
        var velocity = panGestureRecognizer.velocityInView(view)
        
        //let location = sender.locationInView(view)
        
        //let translation = sender.translationInView(view)
        
        //let velocity = sender.velocityInView(view)
        
        
        
        if panGestureRecognizer.state == UIGestureRecognizerState.Began {
        
            
            print("You started", terminator: "")
            
            
            
            //initialCenter = singlemsgImg.center
            
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
            
            print("You changed: \(initialCenter)", terminator: "")

            
            
            //move in x axis but not y
            //singlemsgImg.center = CGPoint(x: initialCenter.x + translation.x, y: initialCenter.y)
            
            
            singlemsgImg.frame.origin.x = CGFloat(initialCenter.x + translation.x)
            
            
            archiveicnImg.frame.origin.x = CGFloat(archiveInitialFrame.x + translation.x - 40)
            deleteicnImg.frame.origin.x = CGFloat(deleteInitialFrame.x + translation.x - 40)
            latericnImg.frame.origin.x = CGFloat(laterInitialFrame.x + translation.x + 40)
            listicnImg.frame.origin.x = CGFloat(listInitialFrame.x + translation.x + 40)
        
            
            
            if translation.x > 0 && translation.x <= 60 {
                singlemsgView.backgroundColor = UIColorFromHex(0xDCDFE0, alpha:1.0)
                if translation.x > 30 {archiveicnImg.hidden = false}
                
            } else if translation.x > 60 && translation.x <= 260 {
                singlemsgView.backgroundColor = UIColorFromHex(0x55D959, alpha: 1.0)
                archiveicnImg.hidden = false
                
            } else if translation.x > 260 {
                singlemsgView.backgroundColor = UIColorFromHex(0xF24D44, alpha: 1.0)
                deleteicnImg.hidden = false
                
                
            } else if translation.x > -60 && translation.x < 0 {
                singlemsgView.backgroundColor = UIColorFromHex(0xDCDFE0, alpha: 1.0)
               latericnImg.hidden = false
                
            } else if translation.x > -260 && translation.x < -60 {
                singlemsgView.backgroundColor = UIColorFromHex(0xFFE066, alpha: 1.0)
                latericnImg.hidden = false
                
            } else if translation.x < -260 {
                singlemsgView.backgroundColor = UIColorFromHex(0xBF9F7E, alpha: 1.0)
                listicnImg.hidden = false
                
            }

            
           
            
            
        }
            
         else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
            
            if translation.x > -60 && translation.x < 60 {
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.singlemsgImg.frame.origin.x = self.initialCenter.x
                })
                
            }
            
                
            else if translation.x < -60 && translation.x > -260 {
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.singlemsgImg.frame.origin.x = self.initialCenter.x
                })
                //singlemsgView.backgroundColor = UIColorFromHex(0xFECA16)
                //self.latericnImg.alpha = 0
                self.listicnImg.alpha = 1
                self.rescheduleImg.alpha = 1
                
            }

            
                
            else if translation.x < -260{
                //singlemsgView.backgroundColor = UIColorFromHex(0xFECA16)
                //self.latericnImg.alpha = 0
                //self.listicnImg.alpha = 0
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.singlemsgImg.frame.origin.x = self.initialCenter.x
                })
                
                UIView.animateWithDuration(0.1) { () -> Void in
                    self.listImg.alpha = 1
                }
            }

            
           
        }
    }
        
    
    
    @IBAction func closeList(sender: UITapGestureRecognizer) {
        UIView.animateWithDuration(0.1) { () -> Void in
            self.listImg.alpha = 0
        }
        self.singlemsgImg.frame.origin.x = self.initialCenter.x
    }
 
    @IBAction func closeReschedule(sender: UITapGestureRecognizer) {
        UIView.animateWithDuration(0.1) { () -> Void in
            self.rescheduleImg.alpha = 0
        }
        self.singlemsgImg.frame.origin.x = self.initialCenter.x

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
