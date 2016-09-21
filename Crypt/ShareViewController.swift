//
//  ShareViewController.swift
//  Crypt
//
//  Created by Mac Owner on 18/04/2016.
//  Copyright © 2016 Crypt transfer. All rights reserved.
//

import UIKit
import Social
import FBSDKShareKit

class ShareViewController: UIViewController, FBSDKSharingDelegate {
    
    @IBOutlet weak var facebook: UIButton!
    @IBOutlet weak var twitter: UIButton!
    @IBOutlet weak var whatsapp: UIButton!
    @IBOutlet weak var others: UIButton!
    
    let sharingText = "Dowload Crypt now on the app store "
    let sharingURL = NSURL(string: GlobalPrefs.sharedInstance.sharingUrl)
    let logoURL = NSURL(string: GlobalPrefs.sharedInstance.logoUrl)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (!SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter)){
            twitter.hidden = true
        }
        if (!UIApplication.sharedApplication().canOpenURL(NSURL(string: "whatsapp://send")!)){
            whatsapp.hidden = true
        }
        if(facebook.hidden && twitter.hidden && whatsapp.hidden){
            // If all other buttons are hidden, the remaining button is tapped by default
            shareWithOtherMethods()
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func shareWithFacebook(sender: UIButton){
        let content = FBSDKShareLinkContent()
        content.contentURL = sharingURL
        content.contentTitle = "Crypt"
        content.imageURL = logoURL
        content.contentDescription = sharingText
        FBSDKShareDialog.showFromViewController(self, withContent: content, delegate: self)
    }
    
    @IBAction func shareWithTwitter(sender: UIButton){
        let composer = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        composer.setInitialText(sharingText + sharingURL!.absoluteString)
        self.presentViewController(composer, animated: true, completion: nil)
    }
    
    @IBAction func shareWithOtherMethods(){
        let controller = UIActivityViewController(activityItems: [sharingText, sharingURL!], applicationActivities: [])
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    @IBAction func shareWithWhatsApp(){
        let urlStringEncoded = (sharingText + sharingURL!.absoluteString).stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
        if let url  = NSURL(string: "whatsapp://send?text=\(urlStringEncoded!)"){
            UIApplication.sharedApplication().openURL(url)
        }
        
        
        
        
    }
    
    // MARK: FBSDKSharingDelegate
    
    func sharer(sharer: FBSDKSharing!, didCompleteWithResults results: [NSObject : AnyObject]!){
        print("facebook sharing completed \(results.debugDescription)")
    }
    

    func sharer(sharer: FBSDKSharing!, didFailWithError error: NSError!){
        print("facebook sharing failed \(error.debugDescription)")
    }
    

    func sharerDidCancel(sharer: FBSDKSharing!){
        print("facebook sharing cancelled")
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
