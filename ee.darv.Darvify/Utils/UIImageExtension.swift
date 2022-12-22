//
//  UIImageExtension.swift
//  ee.darv.Darvify
//
//  Created by Dan on 22-12-22.
//

import Foundation
import UIKit
extension UIImage{
    
    var blur: UIImage {
        let context = CIContext(options: nil)
        let currentFilter = CIFilter(name: "CIGaussianBlur")!
        currentFilter.setValue(CIImage(image: self), forKey: kCIInputImageKey)
        currentFilter.setValue(0.4, forKey: "inputRadius")
        let output = currentFilter.outputImage!
        let cgImage = context.createCGImage(output, from: output.extent)!
        let processedImage = UIImage(cgImage: cgImage, scale: scale, orientation: imageOrientation)
        
        return processedImage
    }
    
    
    var noir: UIImage {
        let context = CIContext(options: nil)
        let currentFilter = CIFilter(name: "CIPhotoEffectNoir")!
        currentFilter.setValue(CIImage(image: self), forKey: kCIInputImageKey)
        let output = currentFilter.outputImage!
        let cgImage = context.createCGImage(output, from: output.extent)!
        let processedImage = UIImage(cgImage: cgImage, scale: scale, orientation: imageOrientation)
        
        return processedImage
    }
    
    var contrast:UIImage{
        let context = CIContext(options: nil)
        let currentFilter = CIFilter(name: "CIColorControls")!
        currentFilter.setValue(CIImage(image: self), forKey: kCIInputImageKey)
        currentFilter.setValue(1, forKey: "inputContrast")
        currentFilter.setValue(0.084, forKey: "inputBrightness")
        currentFilter.setValue(10, forKey: "inputSaturation")
        let output = currentFilter.outputImage!
        let cgImage = context.createCGImage(output, from: output.extent)!
        let processedImage = UIImage(cgImage: cgImage, scale: scale, orientation: imageOrientation)
        
        return processedImage
    }
    
    var invert: UIImage {
        let context = CIContext(options: nil)
        let currentFilter = CIFilter(name: "CIColorInvert")!
        currentFilter.setValue(CIImage(image: self), forKey: kCIInputImageKey)
        let output = currentFilter.outputImage!
        let cgImage = context.createCGImage(output, from: output.extent)!
        let processedImage = UIImage(cgImage: cgImage, scale: scale, orientation: imageOrientation)
        
        return processedImage
    }
    
    var xray: UIImage {
        let context = CIContext(options: nil)
        let currentFilter = CIFilter(name: "CIXRay")!
        currentFilter.setValue(CIImage(image: self), forKey: kCIInputImageKey)
        let output = currentFilter.outputImage!
        let cgImage = context.createCGImage(output, from: output.extent)!
        let processedImage = UIImage(cgImage: cgImage, scale: scale, orientation: imageOrientation)
        
        return processedImage
    }

    

     
    
}

