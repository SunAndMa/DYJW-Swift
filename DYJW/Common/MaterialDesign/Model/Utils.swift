//
//  Utils.swift
//  DYJW
//
//  Created by 国投 on 2016/12/9.
//  Copyright © 2016年 Doge Studio. All rights reserved.
//

import UIKit

class Utils: NSObject {

}

extension String {
    var md5Value: String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen);
        
        CC_MD5(str!, strLen, result);
        
        let hash = NSMutableString();
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i]);
        }
        result.deinitialize();
        
        return String(format: hash as String)
    }
    
}
