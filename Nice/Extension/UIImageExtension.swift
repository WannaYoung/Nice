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
        let imageSize:CGSize = UIScreen.main.bounds.size
        
        UIGraphicsBeginImageContextWithOptions(imageSize, false, 0)
        let context:CGContext = UIGraphicsGetCurrentContext()!
        for window:UIWindow in UIApplication.shared.windows {
            if window.screen == UIScreen.main
            {
                context.saveGState()
                context.translateBy(x: window.center.x, y: window.center.y)
                context.concatenate(window.transform)
                context.translateBy(x: -window.bounds.size.width * window.layer.anchorPoint.x, y: -window.bounds.size.height * window.layer.anchorPoint.y)
                window.layer.render(in: context)
            }
        }
        let image:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    func gaussianBlur(blurAmount:CGFloat) -> UIImage
    {
        var tempAmount:CGFloat = blurAmount
        
        if (tempAmount < 0.0 || tempAmount > 1.0)
        {
            tempAmount = 0.5
        }
        
        var boxSize = Int(tempAmount * 40)
        boxSize = boxSize - (boxSize % 2) + 1
        
        let img = self.cgImage
        
        var inBuffer = vImage_Buffer()
        var outBuffer = vImage_Buffer()
        
        let inProvider =  img?.dataProvider
        let inBitmapData =  inProvider?.data
        
        inBuffer.width = vImagePixelCount(img!.width)
        inBuffer.height = vImagePixelCount(img!.height)
        inBuffer.rowBytes = (img?.bytesPerRow)!
        inBuffer.data = UnsafeMutableRawPointer(mutating: CFDataGetBytePtr(inBitmapData))
        
        let pixelBuffer = malloc((img?.bytesPerRow)! * (img?.height)!)
        
        outBuffer.width = vImagePixelCount(img!.width)
        outBuffer.height = vImagePixelCount(img!.height)
        outBuffer.rowBytes = (img?.bytesPerRow)!
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
        let ctx = CGContext(data: outBuffer.data,
                            width: Int(outBuffer.width),
                            height: Int(outBuffer.height),
                            bitsPerComponent: 8,
                            bytesPerRow: outBuffer.rowBytes,
                            space: colorSpace,
                            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)
        
        let imageRef = ctx!.makeImage()
        
        free(pixelBuffer)
        return UIImage(cgImage: imageRef!)
    }


}
