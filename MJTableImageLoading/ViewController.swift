//
//  ViewController.swift
//  MJTableImageLoading
//
//  Created by Mohamed Jaleel Nazir on 27/05/15.
//  Copyright (c) 2015 Jaleel. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    var tableData = []
    @IBOutlet var appsTableView : UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchItunes("SPF Solutions")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchItunes(searchKey: String)
    {
        let itunesSearchKey = searchKey.stringByReplacingOccurrencesOfString("", withString: "+", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
        if let escapedSeachKey = itunesSearchKey.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        {
            let urlPath = "http://itunes.apple.com/search?term=\(escapedSeachKey)&media=software"
            let url = NSURL(string: urlPath)
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithURL(url!, completionHandler: {data, response, error -> Void in
                println("Task completed")
                if(error != nil) {
                    // If there is an error in the web request, print it to the console
                    println(error.localizedDescription)
                }
                var err: NSError?
                if let jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as? NSDictionary {
                    if(err != nil) {
                        // If there is an error parsing JSON, print it to the console
                        println("JSON Error \(err!.localizedDescription)")
                    }
                    if let results: NSArray = jsonResult["results"] as? NSArray {
                        dispatch_async(dispatch_get_main_queue(), {
                            
                            println("JSON  \(results)")
                            self.tableData = results
                            self.appsTableView!.reloadData()
                        })
                    }
                }
            })
            
            // The task is just an object with all these properties set
            // In order to actually make the web request, we need to "resume"
            task.resume()
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.tableData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
//        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "imagedataCell")
//        
//        if let rowData: NSDictionary = self.tableData[indexPath.row] as? NSDictionary,
//            // Grab the artworkUrl60 key to get an image URL for the app's thumbnail
//            urlString = rowData["artworkUrl60"] as? String,
//            // Create an NSURL instance from the String URL we get from the API
//            imgURL = NSURL(string: urlString),
//            // Get the formatted price string for display in the subtitle
//            formattedPrice = rowData["formattedPrice"] as? String,
//            // Download an NSData representation of the image at the URL
//            imgData = NSData(contentsOfURL: imgURL),
//            // Get the track name
//            trackName = rowData["trackName"] as? String {
//                // Get the formatted price string for display in the subtitle
//                cell.detailTextLabel?.text = formattedPrice
//                // Update the imageView cell to use the downloaded image data
//                cell.imageView?.image = UIImage(data: imgData)
//                // Update the textLabel text to use the trackName from the API
//                cell.textLabel?.text = trackName
//        }
//        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("imagedataCell", forIndexPath: indexPath) as! UITableViewCell
        
        let rowData = self.tableData[indexPath.row] as! NSDictionary
        
        let imgDwldr = (cell.contentView.viewWithTag(1) as! ImageDownloader)
        
        let urlString = rowData["artworkUrl60"] as? String
        
        imgDwldr.startDownload(urlString!)
        
// Create an NSURL instance from the String URL we get from the API
//        let imgURL = NSURL(string: urlString!)
//        // Get the formatted price string for display in the subtitle
//        let formattedPrice = rowData["formattedPrice"] as? String
//        // Download an NSData representation of the image at the URL
//        let imgData = NSData(contentsOfURL: imgURL!)
        
//        (cell.contentView.viewWithTag(1) as! UIImageView).image = UIImage(data: imgData!)
        
        (cell.contentView.viewWithTag(2) as! UILabel).text = rowData["trackName"] as? String
        
        return cell
    }
    
//    func startIconDownload(iconURL : String,  Object imageView: ImageDownloader )
//    {
//        imageView.startDownload(iconURL)
//        
//    }
}




