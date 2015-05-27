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
    var loadingIndicator = UIActivityIndicatorView()
    var currentConnection = NSURLConnection()

    func startDownload(UrlString: String)
    {
        self.image = nil
        
        //Image view height and width are same so we are cal only width
//        var width  = self.bounds.size.width * 0.4
//        self.loadingIndicator = UIActivityIndicatorView(frame: CGRectMake((self.bounds.size.width - width)/2,(self.bounds.size.width - width)/2 , 25.0, 25.0))
//        self.loadingIndicator.color = UIColor.redColor()
        
        self.loadingIndicator = UIActivityIndicatorView(frame: CGRectMake(0,0, 25, 25)) as UIActivityIndicatorView
        self.loadingIndicator.center = self.center
        self.loadingIndicator.hidesWhenStopped = true
        self.loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        self.addSubview(self.loadingIndicator)
        self.loadingIndicator.startAnimating()
        self.bringSubviewToFront(self.loadingIndicator)
//        startLoadingIndicator()
        
        var url: NSURL = NSURL(string: UrlString)!
        var request: NSURLRequest = NSURLRequest(URL: url)
        var connection: NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: true)!
        connection.start()
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
