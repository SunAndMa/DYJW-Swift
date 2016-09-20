//
//  MDColor.swift
//  DYJW
//
//  Created by 风筝 on 16/9/12.
//  Copyright © 2016年 Doge Studio. All rights reserved.
//

import UIKit

extension UIColor {
    
    public class func pureColorImage(color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        CGContextSetFillColorWithColor(context!, color.CGColor)
        CGContextFillRect(context!, rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    public class func rgb(hexColor: Int) -> UIColor {
        let red = CGFloat(hexColor >> 16) / 255.0
        let green = CGFloat(hexColor >> 8 & 0xFF) / 255.0
        let blue = CGFloat(hexColor & 0xFF) / 255.0
        return UIColor.init(red: red, green: green, blue: blue, alpha: 1)
    }
    
    // MARK:- lightBlue
    public class func red50() -> UIColor {return UIColor.rgb(0xfde0dc)}
    public class func red100() -> UIColor {return UIColor.rgb(0xf9bdbb)}
    public class func red200() -> UIColor {return UIColor.rgb(0xf69988)}
    public class func red300() -> UIColor {return UIColor.rgb(0xf36c60)}
    public class func red400() -> UIColor {return UIColor.rgb(0xe84e40)}
    public class func red500() -> UIColor {return UIColor.rgb(0xe51c23)}
    public class func red600() -> UIColor {return UIColor.rgb(0xdd191d)}
    public class func red700() -> UIColor {return UIColor.rgb(0xd01716)}
    public class func red800() -> UIColor {return UIColor.rgb(0xc41411)}
    public class func red900() -> UIColor {return UIColor.rgb(0xb0120a)}
    public class func redA100() -> UIColor {return UIColor.rgb(0xff7997)}
    public class func redA200() -> UIColor {return UIColor.rgb(0xff5177)}
    public class func redA400() -> UIColor {return UIColor.rgb(0xff2d6f)}
    public class func redA700() -> UIColor {return UIColor.rgb(0xe00032)}
    // MARK:- Pink
    public class func pink50() -> UIColor {return UIColor.rgb(0xfce4ec)}
    public class func pink100() -> UIColor {return UIColor.rgb(0xf8bbd0)}
    public class func pink200() -> UIColor {return UIColor.rgb(0xf48fb1)}
    public class func pink300() -> UIColor {return UIColor.rgb(0xf06292)}
    public class func pink400() -> UIColor {return UIColor.rgb(0xec407a)}
    public class func pink500() -> UIColor {return UIColor.rgb(0xe91e63)}
    public class func pink600() -> UIColor {return UIColor.rgb(0xd81b60)}
    public class func pink700() -> UIColor {return UIColor.rgb(0xc2185b)}
    public class func pink800() -> UIColor {return UIColor.rgb(0xad1457)}
    public class func pink900() -> UIColor {return UIColor.rgb(0x880e4f)}
    public class func pinkA100() -> UIColor {return UIColor.rgb(0xff80ab)}
    public class func pinkA200() -> UIColor {return UIColor.rgb(0xff4081)}
    public class func pinkA400() -> UIColor {return UIColor.rgb(0xf50057)}
    public class func pinkA700() -> UIColor {return UIColor.rgb(0xc51162)}
    // MARK:- Purplex
    public class func purple50() -> UIColor {return UIColor.rgb(0xf3e5f5)}
    public class func purple100() -> UIColor {return UIColor.rgb(0xe1bee7)}
    public class func purple200() -> UIColor {return UIColor.rgb(0xce93d8)}
    public class func purple300() -> UIColor {return UIColor.rgb(0xba68c8)}
    public class func purple400() -> UIColor {return UIColor.rgb(0xab47bc)}
    public class func purple500() -> UIColor {return UIColor.rgb(0x9c27b0)}
    public class func purple600() -> UIColor {return UIColor.rgb(0x8e24aa)}
    public class func purple700() -> UIColor {return UIColor.rgb(0x7b1fa2)}
    public class func purple800() -> UIColor {return UIColor.rgb(0x6a1b9a)}
    public class func purple900() -> UIColor {return UIColor.rgb(0x4a148c)}
    public class func purpleA100() -> UIColor {return UIColor.rgb(0xea80fc)}
    public class func purpleA200() -> UIColor {return UIColor.rgb(0xe040fb)}
    public class func purpleA400() -> UIColor {return UIColor.rgb(0xd500f9)}
    public class func purpleA700() -> UIColor {return UIColor.rgb(0xaa00ff)}
    // MARK:- Deep Purple
    public class func deepPurple50() -> UIColor {return UIColor.rgb(0xede7f6)}
    public class func deepPurple100() -> UIColor {return UIColor.rgb(0xd1c4e9)}
    public class func deepPurple200() -> UIColor {return UIColor.rgb(0xb39ddb)}
    public class func deepPurple300() -> UIColor {return UIColor.rgb(0x9575cd)}
    public class func deepPurple400() -> UIColor {return UIColor.rgb(0x7e57c2)}
    public class func deepPurple500() -> UIColor {return UIColor.rgb(0x673ab7)}
    public class func deepPurple600() -> UIColor {return UIColor.rgb(0x5e35b1)}
    public class func deepPurple700() -> UIColor {return UIColor.rgb(0x512da8)}
    public class func deepPurple800() -> UIColor {return UIColor.rgb(0x4527a0)}
    public class func deepPurple900() -> UIColor {return UIColor.rgb(0x311b92)}
    public class func deepPurpleA100() -> UIColor {return UIColor.rgb(0xb388ff)}
    public class func deepPurpleA200() -> UIColor {return UIColor.rgb(0x7c4dff)}
    public class func deepPurpleA400() -> UIColor {return UIColor.rgb(0x651fff)}
    public class func deepPurpleA700() -> UIColor {return UIColor.rgb(0x6200ea)}
    // MARK:- Indigo
    public class func indigo50() -> UIColor {return UIColor.rgb(0xe8eaf6)}
    public class func indigo100() -> UIColor {return UIColor.rgb(0xc5cae9)}
    public class func indigo200() -> UIColor {return UIColor.rgb(0x9fa8da)}
    public class func indigo300() -> UIColor {return UIColor.rgb(0x7986cb)}
    public class func indigo400() -> UIColor {return UIColor.rgb(0x5c6bc0)}
    public class func indigo500() -> UIColor {return UIColor.rgb(0x3f51b5)}
    public class func indigo600() -> UIColor {return UIColor.rgb(0x3949ab)}
    public class func indigo700() -> UIColor {return UIColor.rgb(0x303f9f)}
    public class func indigo800() -> UIColor {return UIColor.rgb(0x283593)}
    public class func indigo900() -> UIColor {return UIColor.rgb(0x1a237e)}
    public class func indigoA100() -> UIColor {return UIColor.rgb(0x8c9eff)}
    public class func indigoA200() -> UIColor {return UIColor.rgb(0x536dfe)}
    public class func indigoA400() -> UIColor {return UIColor.rgb(0x3d5afe)}
    public class func indigoA700() -> UIColor {return UIColor.rgb(0x304ffe)}
    // MARK:- Blue
    public class func blue50() -> UIColor {return UIColor.rgb(0xe7e9fd)}
    public class func blue100() -> UIColor {return UIColor.rgb(0xd0d9ff)}
    public class func blue200() -> UIColor {return UIColor.rgb(0xafbfff)}
    public class func blue300() -> UIColor {return UIColor.rgb(0x91a7ff)}
    public class func blue400() -> UIColor {return UIColor.rgb(0x738ffe)}
    public class func blue500() -> UIColor {return UIColor.rgb(0x5677fc)}
    public class func blue600() -> UIColor {return UIColor.rgb(0x4e6cef)}
    public class func blue700() -> UIColor {return UIColor.rgb(0x455ede)}
    public class func blue800() -> UIColor {return UIColor.rgb(0x3b50ce)}
    public class func blue900() -> UIColor {return UIColor.rgb(0x2a36b1)}
    public class func blueA100() -> UIColor {return UIColor.rgb(0xa6baff)}
    public class func blueA200() -> UIColor {return UIColor.rgb(0x6889ff)}
    public class func blueA400() -> UIColor {return UIColor.rgb(0x4d73ff)}
    public class func blueA700() -> UIColor {return UIColor.rgb(0x4d69ff)}
    // MARK:- Light Blue
    public class func lightBlue50() -> UIColor {return UIColor.rgb(0xe1f5fe)}
    public class func lightBlue100() -> UIColor {return UIColor.rgb(0xb3e5fc)}
    public class func lightBlue200() -> UIColor {return UIColor.rgb(0x81d4fa)}
    public class func lightBlue300() -> UIColor {return UIColor.rgb(0x4fc3f7)}
    public class func lightBlue400() -> UIColor {return UIColor.rgb(0x29b6f6)}
    public class func lightBlue500() -> UIColor {return UIColor.rgb(0x03a9f4)}
    public class func lightBlue600() -> UIColor {return UIColor.rgb(0x039be5)}
    public class func lightBlue700() -> UIColor {return UIColor.rgb(0x0288d1)}
    public class func lightBlue800() -> UIColor {return UIColor.rgb(0x0277bd)}
    public class func lightBlue900() -> UIColor {return UIColor.rgb(0x01579b)}
    public class func lightBlueA100() -> UIColor {return UIColor.rgb(0x80d8ff)}
    public class func lightBlueA200() -> UIColor {return UIColor.rgb(0x40c4ff)}
    public class func lightBlueA400() -> UIColor {return UIColor.rgb(0x00b0ff)}
    public class func lightBlueA700() -> UIColor {return UIColor.rgb(0x0091ea)}
    // MARK:- Cyan
    public class func cyan50() -> UIColor {return UIColor.rgb(0xe0f7fa)}
    public class func cyan100() -> UIColor {return UIColor.rgb(0xb2ebf2)}
    public class func cyan200() -> UIColor {return UIColor.rgb(0x80deea)}
    public class func cyan300() -> UIColor {return UIColor.rgb(0x4dd0e1)}
    public class func cyan400() -> UIColor {return UIColor.rgb(0x26c6da)}
    public class func cyan500() -> UIColor {return UIColor.rgb(0x00bcd4)}
    public class func cyan600() -> UIColor {return UIColor.rgb(0x00acc1)}
    public class func cyan700() -> UIColor {return UIColor.rgb(0x0097a7)}
    public class func cyan800() -> UIColor {return UIColor.rgb(0x00838f)}
    public class func cyan900() -> UIColor {return UIColor.rgb(0x006064)}
    public class func cyanA100() -> UIColor {return UIColor.rgb(0x84ffff)}
    public class func cyanA200() -> UIColor {return UIColor.rgb(0x18ffff)}
    public class func cyanA400() -> UIColor {return UIColor.rgb(0x00e5ff)}
    public class func cyanA700() -> UIColor {return UIColor.rgb(0x00b8d4)}
    // MARK:- Teal
    public class func teal50() -> UIColor {return UIColor.rgb(0xe0f2f1)}
    public class func teal100() -> UIColor {return UIColor.rgb(0xb2dfdb)}
    public class func teal200() -> UIColor {return UIColor.rgb(0x80cbc4)}
    public class func teal300() -> UIColor {return UIColor.rgb(0x4db6ac)}
    public class func teal400() -> UIColor {return UIColor.rgb(0x26a69a)}
    public class func teal500() -> UIColor {return UIColor.rgb(0x009688)}
    public class func teal600() -> UIColor {return UIColor.rgb(0x00897b)}
    public class func teal700() -> UIColor {return UIColor.rgb(0x00796b)}
    public class func teal800() -> UIColor {return UIColor.rgb(0x00695c)}
    public class func teal900() -> UIColor {return UIColor.rgb(0x004d40)}
    public class func tealA100() -> UIColor {return UIColor.rgb(0xa7ffeb)}
    public class func tealA200() -> UIColor {return UIColor.rgb(0x64ffda)}
    public class func tealA400() -> UIColor {return UIColor.rgb(0x1de9b6)}
    public class func tealA700() -> UIColor {return UIColor.rgb(0x00bfa5)}
    // MARK:- Green
    public class func green50() -> UIColor {return UIColor.rgb(0xd0f8ce)}
    public class func green100() -> UIColor {return UIColor.rgb(0xa3e9a4)}
    public class func green200() -> UIColor {return UIColor.rgb(0x72d572)}
    public class func green300() -> UIColor {return UIColor.rgb(0x42bd41)}
    public class func green400() -> UIColor {return UIColor.rgb(0x2baf2b)}
    public class func green500() -> UIColor {return UIColor.rgb(0x259b24)}
    public class func green600() -> UIColor {return UIColor.rgb(0x0a8f08)}
    public class func green700() -> UIColor {return UIColor.rgb(0x0a7e07)}
    public class func green800() -> UIColor {return UIColor.rgb(0x056f00)}
    public class func green900() -> UIColor {return UIColor.rgb(0x0d5302)}
    public class func greenA100() -> UIColor {return UIColor.rgb(0xa2f78d)}
    public class func greenA200() -> UIColor {return UIColor.rgb(0x5af158)}
    public class func greenA400() -> UIColor {return UIColor.rgb(0x14e715)}
    public class func greenA700() -> UIColor {return UIColor.rgb(0x12c700)}
    // MARK:- Light Green
    public class func lightGreen50() -> UIColor {return UIColor.rgb(0xf1f8e9)}
    public class func lightGreen100() -> UIColor {return UIColor.rgb(0xdcedc8)}
    public class func lightGreen200() -> UIColor {return UIColor.rgb(0xc5e1a5)}
    public class func lightGreen300() -> UIColor {return UIColor.rgb(0xaed581)}
    public class func lightGreen400() -> UIColor {return UIColor.rgb(0x9ccc65)}
    public class func lightGreen500() -> UIColor {return UIColor.rgb(0x8bc34a)}
    public class func lightGreen600() -> UIColor {return UIColor.rgb(0x7cb342)}
    public class func lightGreen700() -> UIColor {return UIColor.rgb(0x689f38)}
    public class func lightGreen800() -> UIColor {return UIColor.rgb(0x558b2f)}
    public class func lightGreen900() -> UIColor {return UIColor.rgb(0x33691e)}
    public class func lightGreenA100() -> UIColor {return UIColor.rgb(0xccff90)}
    public class func lightGreenA200() -> UIColor {return UIColor.rgb(0xb2ff59)}
    public class func lightGreenA400() -> UIColor {return UIColor.rgb(0x76ff03)}
    public class func lightGreenA700() -> UIColor {return UIColor.rgb(0x64dd17)}
    // MARK:- Lime
    public class func lime50() -> UIColor {return UIColor.rgb(0xf9fbe7)}
    public class func lime100() -> UIColor {return UIColor.rgb(0xf0f4c3)}
    public class func lime200() -> UIColor {return UIColor.rgb(0xe6ee9c)}
    public class func lime300() -> UIColor {return UIColor.rgb(0xdce775)}
    public class func lime400() -> UIColor {return UIColor.rgb(0xd4e157)}
    public class func lime500() -> UIColor {return UIColor.rgb(0xcddc39)}
    public class func lime600() -> UIColor {return UIColor.rgb(0xc0ca33)}
    public class func lime700() -> UIColor {return UIColor.rgb(0xafb42b)}
    public class func lime800() -> UIColor {return UIColor.rgb(0x9e9d24)}
    public class func lime900() -> UIColor {return UIColor.rgb(0x827717)}
    public class func limeA100() -> UIColor {return UIColor.rgb(0xf4ff81)}
    public class func limeA200() -> UIColor {return UIColor.rgb(0xeeff41)}
    public class func limeA400() -> UIColor {return UIColor.rgb(0xc6ff00)}
    public class func limeA700() -> UIColor {return UIColor.rgb(0xaeea00)}
    // MARK:- Yellow
    public class func yellow50() -> UIColor {return UIColor.rgb(0xfffde7)}
    public class func yellow100() -> UIColor {return UIColor.rgb(0xfff9c4)}
    public class func yellow200() -> UIColor {return UIColor.rgb(0xfff59d)}
    public class func yellow300() -> UIColor {return UIColor.rgb(0xfff176)}
    public class func yellow400() -> UIColor {return UIColor.rgb(0xffee58)}
    public class func yellow500() -> UIColor {return UIColor.rgb(0xffeb3b)}
    public class func yellow600() -> UIColor {return UIColor.rgb(0xfdd835)}
    public class func yellow700() -> UIColor {return UIColor.rgb(0xfbc02d)}
    public class func yellow800() -> UIColor {return UIColor.rgb(0xf9a825)}
    public class func yellow900() -> UIColor {return UIColor.rgb(0xf57f17)}
    public class func yellowA100() -> UIColor {return UIColor.rgb(0xffff8d)}
    public class func yellowA200() -> UIColor {return UIColor.rgb(0xffff00)}
    public class func yellowA400() -> UIColor {return UIColor.rgb(0xffea00)}
    public class func yellowA700() -> UIColor {return UIColor.rgb(0xffd600)}
    // MARK:- Amber
    public class func amber50() -> UIColor {return UIColor.rgb(0xfff8e1)}
    public class func amber100() -> UIColor {return UIColor.rgb(0xffecb3)}
    public class func amber200() -> UIColor {return UIColor.rgb(0xffe082)}
    public class func amber300() -> UIColor {return UIColor.rgb(0xffd54f)}
    public class func amber400() -> UIColor {return UIColor.rgb(0xffca28)}
    public class func amber500() -> UIColor {return UIColor.rgb(0xffc107)}
    public class func amber600() -> UIColor {return UIColor.rgb(0xffb300)}
    public class func amber700() -> UIColor {return UIColor.rgb(0xffa000)}
    public class func amber800() -> UIColor {return UIColor.rgb(0xff8f00)}
    public class func amber900() -> UIColor {return UIColor.rgb(0xff6f00)}
    public class func amberA100() -> UIColor {return UIColor.rgb(0xffe57f)}
    public class func amberA200() -> UIColor {return UIColor.rgb(0xffd740)}
    public class func amberA400() -> UIColor {return UIColor.rgb(0xffc400)}
    public class func amberA700() -> UIColor {return UIColor.rgb(0xffab00)}
    // MARK:- Orange
    public class func orange50() -> UIColor {return UIColor.rgb(0xfff3e0)}
    public class func orange100() -> UIColor {return UIColor.rgb(0xffe0b2)}
    public class func orange200() -> UIColor {return UIColor.rgb(0xffcc80)}
    public class func orange300() -> UIColor {return UIColor.rgb(0xffb74d)}
    public class func orange400() -> UIColor {return UIColor.rgb(0xffa726)}
    public class func orange500() -> UIColor {return UIColor.rgb(0xff9800)}
    public class func orange600() -> UIColor {return UIColor.rgb(0xfb8c00)}
    public class func orange700() -> UIColor {return UIColor.rgb(0xf57c00)}
    public class func orange800() -> UIColor {return UIColor.rgb(0xef6c00)}
    public class func orange900() -> UIColor {return UIColor.rgb(0xe65100)}
    public class func orangeA100() -> UIColor {return UIColor.rgb(0xffd180)}
    public class func orangeA200() -> UIColor {return UIColor.rgb(0xffab40)}
    public class func orangeA400() -> UIColor {return UIColor.rgb(0xff9100)}
    public class func orangeA700() -> UIColor {return UIColor.rgb(0xff6d00)}
    // MARK:- Deep Orange
    public class func deepOrange50() -> UIColor {return UIColor.rgb(0xfbe9e7)}
    public class func deepOrange100() -> UIColor {return UIColor.rgb(0xffccbc)}
    public class func deepOrange200() -> UIColor {return UIColor.rgb(0xffab91)}
    public class func deepOrange300() -> UIColor {return UIColor.rgb(0xff8a65)}
    public class func deepOrange400() -> UIColor {return UIColor.rgb(0xff7043)}
    public class func deepOrange500() -> UIColor {return UIColor.rgb(0xff5722)}
    public class func deepOrange600() -> UIColor {return UIColor.rgb(0xf4511e)}
    public class func deepOrange700() -> UIColor {return UIColor.rgb(0xe64a19)}
    public class func deepOrange800() -> UIColor {return UIColor.rgb(0xd84315)}
    public class func deepOrange900() -> UIColor {return UIColor.rgb(0xbf360c)}
    public class func deepOrangeA100() -> UIColor {return UIColor.rgb(0xff9e80)}
    public class func deepOrangeA200() -> UIColor {return UIColor.rgb(0xff6e40)}
    public class func deepOrangeA400() -> UIColor {return UIColor.rgb(0xff3d00)}
    public class func deepOrangeA700() -> UIColor {return UIColor.rgb(0xdd2c00)}
    // MARK:- Brown
    public class func brown50() -> UIColor {return UIColor.rgb(0xefebe9)}
    public class func brown100() -> UIColor {return UIColor.rgb(0xd7ccc8)}
    public class func brown200() -> UIColor {return UIColor.rgb(0xbcaaa4)}
    public class func brown300() -> UIColor {return UIColor.rgb(0xa1887f)}
    public class func brown400() -> UIColor {return UIColor.rgb(0x8d6e63)}
    public class func brown500() -> UIColor {return UIColor.rgb(0x795548)}
    public class func brown600() -> UIColor {return UIColor.rgb(0x6d4c41)}
    public class func brown700() -> UIColor {return UIColor.rgb(0x5d4037)}
    public class func brown800() -> UIColor {return UIColor.rgb(0x4e342e)}
    public class func brown900() -> UIColor {return UIColor.rgb(0x3e2723)}
    // MARK:- Grey
    public class func grey50() -> UIColor {return UIColor.rgb(0xfafafa)}
    public class func grey100() -> UIColor {return UIColor.rgb(0xf5f5f5)}
    public class func grey200() -> UIColor {return UIColor.rgb(0xeeeeee)}
    public class func grey300() -> UIColor {return UIColor.rgb(0xe0e0e0)}
    public class func grey400() -> UIColor {return UIColor.rgb(0xbdbdbd)}
    public class func grey500() -> UIColor {return UIColor.rgb(0x9e9e9e)}
    public class func grey600() -> UIColor {return UIColor.rgb(0x757575)}
    public class func grey700() -> UIColor {return UIColor.rgb(0x616161)}
    public class func grey800() -> UIColor {return UIColor.rgb(0x424242)}
    public class func grey900() -> UIColor {return UIColor.rgb(0x212121)}
    // MARK:- blueGrey
    public class func blueGrey50() -> UIColor {return UIColor.rgb(0xeceff1)}
    public class func blueGrey100() -> UIColor {return UIColor.rgb(0xcfd8dc)}
    public class func blueGrey200() -> UIColor {return UIColor.rgb(0xb0bec5)}
    public class func blueGrey300() -> UIColor {return UIColor.rgb(0x90a4ae)}
    public class func blueGrey400() -> UIColor {return UIColor.rgb(0x78909c)}
    public class func blueGrey500() -> UIColor {return UIColor.rgb(0x607d8b)}
    public class func blueGrey600() -> UIColor {return UIColor.rgb(0x546e7a)}
    public class func blueGrey700() -> UIColor {return UIColor.rgb(0x455a64)}
    public class func blueGrey800() -> UIColor {return UIColor.rgb(0x37474f)}
    public class func blueGrey900() -> UIColor {return UIColor.rgb(0x263238)}
}
