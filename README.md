# MJTableImageSwift

1.Include the ImageDownloader.swift file into your Project.

2.Select the UIImageView in your viewcontroller from storyboard.

3.Choose the ImageDownloader (UIImageView class) file.

![Identity Inspector image](http://3.bp.blogspot.com/-LjNrLX3_X6o/VWWb9H_sK1I/AAAAAAAAAPk/exMFtTP4SEE/s1600/Screen%2BShot%2B2015-05-27%2Bat%2B3.01.29%2Bpm.png)

4. Use the below code in cellForRowAtIndexPath
5. 

        let imgDwldr = (cell.contentView.viewWithTag(1) as! ImageDownloader)
        
        let urlString = rowData["artworkUrl60"] as? String
        
        imgDwldr.startDownload(urlString!)


# The MIT License (MIT)

Copyright (c) 2015 JaleelNazir

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
