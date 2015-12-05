//
//  ImageDownloader.swift
//  MJTableImageLoading
//
//  Created by Mohamed Jaleel Nazir on 27/05/15.
//  Copyright (c) 2015 Jaleel. All rights reserved.
//

import Foundation
import UIKit


class ImageDownloader: UIImageView {
    
    var data = NSMutableData()
    var fileName : String = ""
    var loadingIndicator = UIActivityIndicatorView()
    var currentConnection = NSURLConnection()

    func startDownload(UrlString: String, name pngfilename : String)
    {
        self.image = nil
        
        //Image view height and width are same so we are cal only width
//        var width  = self.bounds.size.width * 0.4
//        self.loadingIndicator = UIActivityIndicatorView(frame: CGRectMake((self.bounds.size.width - width)/2,(self.bounds.size.width - width)/2 , 25.0, 25.0))
//        self.loadingIndicator.color = UIcolor.redColor()
        
        fileName = pngfilename
        
        self.loadingIndicator = UIActivityIndicatorView(frame: CGRectMake(0,0, 25, 25)) as UIActivityIndicatorView
        self.loadingIndicator.center = self.center
        self.loadingIndicator.hidesWhenStopped = true
        self.loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        self.addSubview(self.loadingIndicator)
        self.loadingIndicator.startAnimating()
        self.bringSubviewToFront(self.loadingIndicator)
//        startLoadingIndicator()
        
        let url: NSURL = NSURL(string: UrlString)!
        let request: NSURLRequest = NSURLRequest(URL: url)
        let connection: NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: true)!
        
        let fileManager = NSFileManager.defaultManager()
        
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] 
        
        let getImagePath = (paths as NSString).stringByAppendingPathComponent("\(fileName).png")
        
        if (fileManager.fileExistsAtPath(getImagePath))
        {
            print("FILE AVAILABLE");
            //Pick Image and Use accordingly
            let imageis: UIImage = UIImage(contentsOfFile: getImagePath)!
            
            self.image = imageis
            
            connection.cancel()
            self.loadingIndicator.stopAnimating()
        }
        else
        {
            connection.start()
        }
    }
    
    func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse)
    {
        self.data = NSMutableData()
    }
    func connection(connection: NSURLConnection, didReceiveData data: NSData)
    {
        self.data.appendData(data)
    }
    func connectionDidFinishLoading(connection: NSURLConnection)
    {
        self.image = UIImage(data: self.data)
        self.loadingIndicator.stopAnimating()
        let fileManager = NSFileManager.defaultManager()
        
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] 
        
        print("FILE NOT AVAILABLE");
        
        let filePathToWrite = "\(paths)/\(fileName).png"
        
        if let imageData = UIImagePNGRepresentation(self.image!)  {
            fileManager.createFileAtPath(filePathToWrite, contents: imageData, attributes: nil)
        }
    }
    func connection(connection: NSURLConnection, didFailWithError error: NSError)
    {
        
    }
    
//    func startLoadingIndicator()
//    {
//        if((self.loadingIndicator.superview) != nil)
//        {
//            self.addSubview(self.loadingIndicator)
//        }
//        self.loadingIndicator.startAnimating()
//    
//    }
}
