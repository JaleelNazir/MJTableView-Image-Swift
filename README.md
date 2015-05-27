# MJTableImageSwift

1.Include the ImageDownloader.swift file into your Project.

2.Select the UIImageView in your viewcontroller from storyboard.

3.Choose the ImageDownloader (UIImageView class) file.

        let imgDwldr = (cell.contentView.viewWithTag(1) as! ImageDownloader)
        
        let urlString = rowData["artworkUrl60"] as? String
        
        imgDwldr.startDownload(urlString!)
        


