//
//  DummyViewController.swift
//  NewsAPI_1
//
//  Created by Ram on 25/07/21.
//

import UIKit

class DummyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.hidesBarsOnTap = true
        self.tabBarController?.tabBar.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onTapOfShareBtn(_ sender: UIButton)
    {
        // Setting description
           let firstActivityItem = "Share this News"

           // Setting url
           let secondActivityItem : NSURL = NSURL(string: "https://www.thehindu.com/")!
        //Share this News
           
           // If you want to use an image
           let image : UIImage = UIImage(named: "category05")!
           let activityViewController : UIActivityViewController = UIActivityViewController(
               activityItems: [firstActivityItem, secondActivityItem, image], applicationActivities: nil)
           
           // This lines is for the popover you need to show in iPad
        activityViewController.popoverPresentationController?.sourceView = (sender )
           
           // This line remove the arrow of the popover to show in iPad
           activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.down
           activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
           
           // Pre-configuring activity items
           activityViewController.activityItemsConfiguration = [
           UIActivity.ActivityType.message
           ] as? UIActivityItemsConfigurationReading
           
           // Anything you want to exclude
//           activityViewController.excludedActivityTypes = [
//               UIActivity.ActivityType.postToWeibo,
//               UIActivity.ActivityType.print,
//               UIActivity.ActivityType.assignToContact,
//               UIActivity.ActivityType.saveToCameraRoll,
//               UIActivity.ActivityType.addToReadingList,
//               UIActivity.ActivityType.postToFlickr,
//               UIActivity.ActivityType.postToVimeo,
//               UIActivity.ActivityType.postToTencentWeibo,
//               UIActivity.ActivityType.postToFacebook
//           ]
           
           activityViewController.isModalInPresentation = true
           self.present(activityViewController, animated: true, completion: nil)
    }
    @IBAction func onTapOfButton(_ sender: UIBarButtonItem) {
        // Setting description
           let firstActivityItem = "Description you want.."

           // Setting url
           let secondActivityItem : NSURL = NSURL(string: "https://www.thehindu.com/")!
           
           // If you want to use an image
           let image : UIImage = UIImage(named: "category05")!
           let activityViewController : UIActivityViewController = UIActivityViewController(
               activityItems: [firstActivityItem, secondActivityItem, image], applicationActivities: nil)
           
           // This lines is for the popover you need to show in iPad
           activityViewController.popoverPresentationController?.sourceView = (sender as! UIButton)
           
           // This line remove the arrow of the popover to show in iPad
           activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.down
           activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
           
           // Pre-configuring activity items
           activityViewController.activityItemsConfiguration = [
           UIActivity.ActivityType.message
           ] as? UIActivityItemsConfigurationReading
           
           // Anything you want to exclude
           activityViewController.excludedActivityTypes = [
               UIActivity.ActivityType.postToWeibo,
               UIActivity.ActivityType.print,
               UIActivity.ActivityType.assignToContact,
               UIActivity.ActivityType.saveToCameraRoll,
               UIActivity.ActivityType.addToReadingList,
               UIActivity.ActivityType.postToFlickr,
               UIActivity.ActivityType.postToVimeo,
               UIActivity.ActivityType.postToTencentWeibo,
               UIActivity.ActivityType.postToFacebook
           ]
           
           activityViewController.isModalInPresentation = true
           self.present(activityViewController, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
