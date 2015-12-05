//
//  ViewController.swift
//  MJTableImageLoading
//
//  Created by Mohamed Jaleel Nazir on 27/05/15.
//  Copyright (c) 2015 Jaleel. All rights reserved.
//

import UIKit


class ViewController: UIViewController,NSURLSessionDelegate,NSURLSessionDataDelegate {
    
    var tableData = []
    var session :NSURLSession!
    var ItunesData : NSMutableData! = NSMutableData()
    
    @IBOutlet var appsTableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Search_ByURL("SPF Solutions")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func Search_ByURL(searchKey :String)
    {
        let itunesSearchKey = searchKey.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
        if let escapedSeachKey = itunesSearchKey.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLPathAllowedCharacterSet())
        {
            let urlPath = "https://itunes.apple.com/search?term=\(escapedSeachKey)&media=software"
            let url = NSURL(string: urlPath)
            let request: NSMutableURLRequest = NSMutableURLRequest(URL: url!)
            let connection: NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: true)!
            connection.start()
        }
    }
    
    func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse)
    {
        ItunesData = NSMutableData()
        NSLog("%@",response.description)
        //here you can get full lenth of your content
        let  lenth = Int(response.expectedContentLength)
        print(lenth)
    }
    
    func connection(connection: NSURLConnection, didReceiveData data: NSData)
    {
        ItunesData.appendData(data)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection)
    {
        do {
            let jsonResult = try NSJSONSerialization.JSONObjectWithData(ItunesData, options:NSJSONReadingOptions.MutableContainers) as! NSDictionary
            
            if let results: NSArray = jsonResult["results"] as? NSArray {
                //                                dispatch_async(dispatch_get_main_queue(), {
                
                print("JSON  \(results)")
                self.tableData = results
                self.appsTableView!.reloadData()
                //                                })
            }
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    
//    func searchItunes(searchKey: String)
//    {
//        let itunesSearchKey = searchKey.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
//        if let escapedSeachKey = itunesSearchKey.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLPathAllowedCharacterSet())
//        {
//            let urlPath = "https://itunes.apple.com/search?term=\(escapedSeachKey)&media=software"
//            let url = NSURL(string: urlPath)
//            
//            
//            let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
//            session = NSURLSession(configuration: configuration, delegate: self, delegateQueue:NSOperationQueue.mainQueue())
//            let task = session.dataTaskWithURL(url!)
//            
//            //            let task = session.dataTaskWithURL(url!, completionHandler: {data, response, error -> Void in
//            //                println("Task completed")
//            //                if(error != nil) {
//            //                    // If there is an error in the web request, print it to the console
//            //                    println(error.localizedDescription)
//            //                }
//            //                var err: NSError?
//            //                if let jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as? NSDictionary {
//            //                    if(err != nil) {
//            //                        // If there is an error parsing JSON, print it to the console
//            //                        println("JSON Error \(err!.localizedDescription)")
//            //                    }
//            //                    if let results: NSArray = jsonResult["results"] as? NSArray {
//            //                        dispatch_async(dispatch_get_main_queue(), {
//            //
//            //                            println("JSON  \(results)")
//            //                            self.tableData = results
//            //                            self.appsTableView!.reloadData()
//            //                        })
//            //                    }
//            //                }
//            //            })
//            // The task is just an object with all these properties set
//            // In order to actually make the web request, we need to "resume"
//            task.resume()
//        }
//    }
//    
//    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveResponse response: NSURLResponse, completionHandler: (NSURLSessionResponseDisposition) -> Void) {
//        NSLog("%@",response.description)
//        //here you can get full lenth of your content
//        let  lenth = Int(response.expectedContentLength)
//        print(lenth)
//        completionHandler(NSURLSessionResponseDisposition.Allow)
//    }
//    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveData data: NSData) {
//        
//        //This buffor will show you how much data you downloaded
//        ItunesData.appendData(data)
//        print("\(ItunesData.length)")
//        
//        //you can set value for progress bar here
//        
//    }
//    func URLSession(session: NSURLSession, downloadTask:NSURLSessionDownloadTask, didFinishDownloadingToURL location: NSURL) {
//        
//        print("Task completed")
//        
//        do {
//            let jsonResult = try NSJSONSerialization.JSONObjectWithData(ItunesData, options:NSJSONReadingOptions.MutableContainers ) as! NSDictionary
//            
//            if let results: NSArray = jsonResult["results"] as? NSArray {
//                //                                dispatch_async(dispatch_get_main_queue(), {
//                
//                print("JSON  \(results)")
//                self.tableData = results
//                self.appsTableView!.reloadData()
//                //                                })
//            }
//        }
//        catch let error as NSError {
//            print(error.localizedDescription)
//        }
//    }
//    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
//        
//    }
    
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
        
        let cell = tableView.dequeueReusableCellWithIdentifier("imagedataCell", forIndexPath: indexPath)
        
        let rowData = self.tableData[indexPath.row] as! NSDictionary
        
        let appName = rowData["trackName"] as? String
        
        (cell.contentView.viewWithTag(2) as! UILabel).text = appName
        
        let imgDwldr = (cell.contentView.viewWithTag(1) as! ImageDownloader)
        
        let urlString = rowData["artworkUrl60"] as? String
        
        imgDwldr.startDownload(urlString!, name: appName!)
        
// Create an NSURL instance from the String URL we get from the API
//        let imgURL = NSURL(string: urlString!)
//        // Get the formatted price string for display in the subtitle
//        let formattedPrice = rowData["formattedPrice"] as? String
//        // Download an NSData representation of the image at the URL
//        let imgData = NSData(contentsOfURL: imgURL!)
//        (cell.contentView.viewWithTag(1) as! UIImageView).image = UIImage(data: imgData!)
        
        return cell
    }
    
    //    func startIconDownload(iconURL : String,  Object imageView: ImageDownloader )
    //    {
    //        imageView.startDownload(iconURL)
    //        
    //    }
}




