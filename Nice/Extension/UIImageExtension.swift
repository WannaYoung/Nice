//
//  UIImageExtension.swift
//  MyCenter
//
//  Created by yang on 16/1/27.
//  Copyright © 2016年 yang. All rights reserved.
//

import UIKit
import QuartzCore
import Accelerate

extension UIImage
{
    class func screenshot() -> UIImage
    {
        let imageSize:CGSize = UIScreen.mainScreen().bounds.size
        
        UIGraphicsBeginImageContextWithOptions(imageSize, false, 0)
        let context:CGContextRef = UIGraphicsGetCurrentContext()!
        for window:UIWindow in UIApplication.sharedApplication().windows
        {
            if !window.respondsToSelector("screen") || window.screen == UIScreen.mainScreen()
            {
                CGContextSaveGState(context)
                CGContextTranslateCTM(context, window.center.x, window.center.y)
                CGContextConcatCTM(context, window.transform)
                CGContextTranslateCTM(context, -window.bounds.size.width * window.layer.anchorPoint.x, -window.bounds.size.height * window.layer.anchorPoint.y)
                window.layer.renderInContext(context)
            }
        }
        let image:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func gaussianBlur(var blurAmount:CGFloat) -> UIImage
    {
        if (blurAmount < 0.0 || blurAmount > 1.0) {
            blurAmount = 0.5
        }
        
        var boxSize = Int(blurAmount * 40)
        boxSize = boxSize - (boxSize % 2) + 1
        
        let img = self.CGImage
        
        var inBuffer = vImage_Buffer()
        var outBuffer = vImage_Buffer()
        
        let inProvider =  CGImageGetDataProvider(img)
        let inBitmapData =  CGDataProviderCopyData(inProvider)
        
        inBuffer.width = vImagePixelCount(CGImageGetWidth(img))
        inBuffer.height = vImagePixelCount(CGImageGetHeight(img))
        inBuffer.rowBytes = CGImageGetBytesPerRow(img)
        inBuffer.data = UnsafeMutablePointer<Void>(CFDataGetBytePtr(inBitmapData))
        
        let pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img))
        
        outBuffer.width = vImagePixelCount(CGImageGetWidth(img))
        outBuffer.height = vImagePixelCount(CGImageGetHeight(img))
        outBuffer.rowBytes = CGImageGetBytesPerRow(img)
        outBuffer.data = pixelBuffer
        
        var error = vImageBoxConvolve_ARGB8888(&inBuffer,
            &outBuffer, nil, vImagePixelCount(0), vImagePixelCount(0),
            UInt32(boxSize), UInt32(boxSize), nil, vImage_Flags(kvImageEdgeExtend))
        if (kvImageNoError != error)
        {
            error = vImageBoxConvolve_ARGB8888(&inBuffer,
                &outBuffer, nil, vImagePixelCount(0), vImagePixelCount(0),
                UInt32(boxSize), UInt32(boxSize), nil, vImage_Flags(kvImageEdgeExtend))
            if (kvImageNoError != error)
            {
                error = vImageBoxConvolve_ARGB8888(&inBuffer,
                    &outBuffer, nil, vImagePixelCount(0), vImagePixelCount(0),
                    UInt32(boxSize), UInt32(boxSize), nil, vImage_Flags(kvImageEdgeExtend))
            }
        }
        
        let colorSpace =  CGColorSpaceCreateDeviceRGB()
        let ctx = CGBitmapContextCreate(outBuffer.data,
            Int(outBuffer.width),
            Int(outBuffer.height),
            8,
            outBuffer.rowBytes,
            colorSpace,
            CGImageAlphaInfo.PremultipliedLast.rawValue)
        
        let imageRef = CGBitmapContextCreateImage(ctx)
        
        free(pixelBuffer)
        return UIImage(CGImage: imageRef!)
    }


}