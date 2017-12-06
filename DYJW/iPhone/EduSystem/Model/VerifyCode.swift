//
//  VerifyCode.swift
//  DYJW
//
//  Created by 风筝 on 2017/12/6.
//  Copyright © 2017年 Doge Studio. All rights reserved.
//

import UIKit

class VerifyCode: NSObject {
    
    static func loadVerifycodeImage(_ completion: @escaping (VerifyCode?) -> Void) {
        
    }
    
    fileprivate(set) var recognizedCode: NSString?
    fileprivate(set) var verifycodeImage: UIImage?
    
    fileprivate func recognizeVerifycode(_ image: UIImage) -> String? {
        let letters = ["b", "c", "m", "n", "v", "x", "z", "1", "2", "3"]
        // 该二维数组中的每一个一维数组是letters数组中相应字母的点阵表示按照二进制转换为十进制的数值
        // 如b的第一列是01111111即十进制的4095
        let nums = [
            [4095, 4095, 1584, 3096, 3096, 3640, 2032, 992],
            [992, 2032, 3640, 3096, 3096, 3640, 560],
            [4088, 4088, 48, 24, 24, 4088, 4080, 48, 24, 24, 4088, 4080],
            [4088, 4088, 48, 24, 24, 24, 4088, 4080],
            [56, 504, 4032, 3584, 4032, 504, 56],
            [3096, 3640, 2032, 448, 2032, 3640, 3096],
            [3096, 3864, 3992, 3544, 3320, 3192, 3096],
            [24, 12, 6, 4095, 4095],
            [3084, 3598, 3847, 3459, 3523, 3299, 3198, 3100],
            [772, 1798, 3587, 3123, 3123, 3699, 2047, 974]
        ]
        
        let imageWidth = 45
        let imageHeight = 12
        let bytesPerRow = imageWidth * 4
        
        
        guard let cgImage = image.cgImage?.cropping(to: CGRect(x: 3, y: 4, width: 45, height: 12)) else {
            return nil
        }
        
        var data: Data?
        let colorSpace = CGColorSpaceCreateDeviceRGB()
//        let context = CGContext(data: &data, width: imageWidth, height: imageHeight, bitsPerComponent: 8, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast)
        
//        let pixelData=CGDataProviderCopyData(CGImageGetDataProvider(self.CGImage))
//        let data:UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
//        let pixelInfo: Int = ((Int(self.size.width) * Int(pos.y)) + Int(pos.x)) * 4
//
//        let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
//        let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
//        let b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
//        let a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)
        
        return nil
    }
    
}
