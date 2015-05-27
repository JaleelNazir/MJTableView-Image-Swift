# MJTableImageSwift

1.Include the ImageDownloader.swift file into your Project.

2.Select the UIImageView in your viewcontroller from storyboard.

3.Choose the ImageDownloader (UIImageView class) file.

        let imgDwldr = (cell.contentView.viewWithTag(1) as! ImageDownloader)
        
        let urlString = rowData["artworkUrl60"] as? String
        
        imgDwldr.startDownload(urlString!)
        
![Identity Inspector image](http://3.bp.blogspot.com/-LjNrLX3_X6o/VWWb9H_sK1I/AAAAAAAAAPk/exMFtTP4SEE/s1600/Screen%2BShot%2B2015-05-27%2Bat%2B3.01.29%2Bpm.png)
        
