//
//  Color.swift
//  FKTools
//
//  Created by FlyKite on 2017/9/23.
//  Copyright © 2017年 Doge Studio. All rights reserved.
//

import UIKit

extension UIColor {
    
    var red: CGFloat {
        get {
            var red: CGFloat = 0
            self.getRed(&red, green: nil, blue: nil, alpha: nil)
            return red
        }
    }
    
    var green: CGFloat {
        get {
            var green: CGFloat = 0
            self.getRed(nil, green: &green, blue: nil, alpha: nil)
            return green
        }
    }
    
    var blue: CGFloat {
        get {
            var blue: CGFloat = 0
            self.getRed(nil, green: nil, blue: &blue, alpha: nil)
            return blue
        }
    }
    
    var alpha: CGFloat {
        get {
            var alpha: CGFloat = 0
            self.getRed(nil, green: nil, blue: nil, alpha: &alpha)
            return alpha
        }
    }
    
    func transition(to color: UIColor, progress: CGFloat) -> UIColor {
        let red = self.red + (color.red - self.red) * progress
        let green = self.green + (color.green - self.green) * progress
        let blue = self.blue + (color.blue - self.blue) * progress
        let alpha = self.alpha + (color.alpha - self.alpha) * progress
        let resultColor = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return resultColor
    }
}

extension Int {
    
    var rgbColor: UIColor {
        return self.rgbColor(alpha: 1)
    }
    
    @available(iOS 10.0, *)
    var rgbP3Color: UIColor {
        return self.rgbP3Color(alpha: 1)
    }
    
    func rgbColor(alpha: CGFloat) -> UIColor {
        let red = CGFloat(self >> 16) / 255.0
        let green = CGFloat((self >> 8) & 0xFF) / 255.0
        let blue = CGFloat(self & 0xFF) / 255.0
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    @available(iOS 10.0, *)
    func rgbP3Color(alpha: CGFloat) -> UIColor {
        let red = CGFloat(self >> 16) / 255.0
        let green = CGFloat((self >> 8) & 0xFF) / 255.0
        let blue = CGFloat(self & 0xFF) / 255.0
        return UIColor(displayP3Red: red, green: green, blue: blue, alpha: alpha)
    }
    
}

// MARK:- Material Design Colors
extension UIColor {
    
    // MARK:- Red
    static let red50: UIColor   = 0xfde0dc.rgbColor
    static let red100: UIColor  = 0xf9bdbb.rgbColor
    static let red200: UIColor  = 0xf69988.rgbColor
    static let red300: UIColor  = 0xf36c60.rgbColor
    static let red400: UIColor  = 0xe84e40.rgbColor
    static let red500: UIColor  = 0xe51c23.rgbColor
    static let red600: UIColor  = 0xdd191d.rgbColor
    static let red700: UIColor  = 0xd01716.rgbColor
    static let red800: UIColor  = 0xc41411.rgbColor
    static let red900: UIColor  = 0xb0120a.rgbColor
    static let redA100: UIColor = 0xff7997.rgbColor
    static let redA200: UIColor = 0xff5177.rgbColor
    static let redA400: UIColor = 0xff2d6f.rgbColor
    static let redA700: UIColor = 0xe00032.rgbColor
    
    // MARK:- Pink
    static let pink50: UIColor   = 0xfce4ec.rgbColor
    static let pink100: UIColor  = 0xf8bbd0.rgbColor
    static let pink200: UIColor  = 0xf48fb1.rgbColor
    static let pink300: UIColor  = 0xf06292.rgbColor
    static let pink400: UIColor  = 0xec407a.rgbColor
    static let pink500: UIColor  = 0xe91e63.rgbColor
    static let pink600: UIColor  = 0xd81b60.rgbColor
    static let pink700: UIColor  = 0xc2185b.rgbColor
    static let pink800: UIColor  = 0xad1457.rgbColor
    static let pink900: UIColor  = 0x880e4f.rgbColor
    static let pinkA100: UIColor = 0xff80ab.rgbColor
    static let pinkA200: UIColor = 0xff4081.rgbColor
    static let pinkA400: UIColor = 0xf50057.rgbColor
    static let pinkA700: UIColor = 0xc51162.rgbColor
    
    // MARK:- Purplex
    static let purple50: UIColor   = 0xf3e5f5.rgbColor
    static let purple100: UIColor  = 0xe1bee7.rgbColor
    static let purple200: UIColor  = 0xce93d8.rgbColor
    static let purple300: UIColor  = 0xba68c8.rgbColor
    static let purple400: UIColor  = 0xab47bc.rgbColor
    static let purple500: UIColor  = 0x9c27b0.rgbColor
    static let purple600: UIColor  = 0x8e24aa.rgbColor
    static let purple700: UIColor  = 0x7b1fa2.rgbColor
    static let purple800: UIColor  = 0x6a1b9a.rgbColor
    static let purple900: UIColor  = 0x4a148c.rgbColor
    static let purpleA100: UIColor = 0xea80fc.rgbColor
    static let purpleA200: UIColor = 0xe040fb.rgbColor
    static let purpleA400: UIColor = 0xd500f9.rgbColor
    static let purpleA700: UIColor = 0xaa00ff.rgbColor
    
    // MARK:- Deep Purple
    static let deepPurple50: UIColor   = 0xede7f6.rgbColor
    static let deepPurple100: UIColor  = 0xd1c4e9.rgbColor
    static let deepPurple200: UIColor  = 0xb39ddb.rgbColor
    static let deepPurple300: UIColor  = 0x9575cd.rgbColor
    static let deepPurple400: UIColor  = 0x7e57c2.rgbColor
    static let deepPurple500: UIColor  = 0x673ab7.rgbColor
    static let deepPurple600: UIColor  = 0x5e35b1.rgbColor
    static let deepPurple700: UIColor  = 0x512da8.rgbColor
    static let deepPurple800: UIColor  = 0x4527a0.rgbColor
    static let deepPurple900: UIColor  = 0x311b92.rgbColor
    static let deepPurpleA100: UIColor = 0xb388ff.rgbColor
    static let deepPurpleA200: UIColor = 0x7c4dff.rgbColor
    static let deepPurpleA400: UIColor = 0x651fff.rgbColor
    static let deepPurpleA700: UIColor = 0x6200ea.rgbColor
    
    // MARK:- Indigo
    static let indigo50: UIColor   = 0xe8eaf6.rgbColor
    static let indigo100: UIColor  = 0xc5cae9.rgbColor
    static let indigo200: UIColor  = 0x9fa8da.rgbColor
    static let indigo300: UIColor  = 0x7986cb.rgbColor
    static let indigo400: UIColor  = 0x5c6bc0.rgbColor
    static let indigo500: UIColor  = 0x3f51b5.rgbColor
    static let indigo600: UIColor  = 0x3949ab.rgbColor
    static let indigo700: UIColor  = 0x303f9f.rgbColor
    static let indigo800: UIColor  = 0x283593.rgbColor
    static let indigo900: UIColor  = 0x1a237e.rgbColor
    static let indigoA100: UIColor = 0x8c9eff.rgbColor
    static let indigoA200: UIColor = 0x536dfe.rgbColor
    static let indigoA400: UIColor = 0x3d5afe.rgbColor
    static let indigoA700: UIColor = 0x304ffe.rgbColor
    
    // MARK:- Blue
    static let blue50: UIColor   = 0xe7e9fd.rgbColor
    static let blue100: UIColor  = 0xd0d9ff.rgbColor
    static let blue200: UIColor  = 0xafbfff.rgbColor
    static let blue300: UIColor  = 0x91a7ff.rgbColor
    static let blue400: UIColor  = 0x738ffe.rgbColor
    static let blue500: UIColor  = 0x5677fc.rgbColor
    static let blue600: UIColor  = 0x4e6cef.rgbColor
    static let blue700: UIColor  = 0x455ede.rgbColor
    static let blue800: UIColor  = 0x3b50ce.rgbColor
    static let blue900: UIColor  = 0x2a36b1.rgbColor
    static let blueA100: UIColor = 0xa6baff.rgbColor
    static let blueA200: UIColor = 0x6889ff.rgbColor
    static let blueA400: UIColor = 0x4d73ff.rgbColor
    static let blueA700: UIColor = 0x4d69ff.rgbColor
    
    // MARK:- Light Blue
    static let lightBlue50: UIColor   = 0xe1f5fe.rgbColor
    static let lightBlue100: UIColor  = 0xb3e5fc.rgbColor
    static let lightBlue200: UIColor  = 0x81d4fa.rgbColor
    static let lightBlue300: UIColor  = 0x4fc3f7.rgbColor
    static let lightBlue400: UIColor  = 0x29b6f6.rgbColor
    static let lightBlue500: UIColor  = 0x03a9f4.rgbColor
    static let lightBlue600: UIColor  = 0x039be5.rgbColor
    static let lightBlue700: UIColor  = 0x0288d1.rgbColor
    static let lightBlue800: UIColor  = 0x0277bd.rgbColor
    static let lightBlue900: UIColor  = 0x01579b.rgbColor
    static let lightBlueA100: UIColor = 0x80d8ff.rgbColor
    static let lightBlueA200: UIColor = 0x40c4ff.rgbColor
    static let lightBlueA400: UIColor = 0x00b0ff.rgbColor
    static let lightBlueA700: UIColor = 0x0091ea.rgbColor
    
    // MARK:- Cyan
    static let cyan50: UIColor   = 0xe0f7fa.rgbColor
    static let cyan100: UIColor  = 0xb2ebf2.rgbColor
    static let cyan200: UIColor  = 0x80deea.rgbColor
    static let cyan300: UIColor  = 0x4dd0e1.rgbColor
    static let cyan400: UIColor  = 0x26c6da.rgbColor
    static let cyan500: UIColor  = 0x00bcd4.rgbColor
    static let cyan600: UIColor  = 0x00acc1.rgbColor
    static let cyan700: UIColor  = 0x0097a7.rgbColor
    static let cyan800: UIColor  = 0x00838f.rgbColor
    static let cyan900: UIColor  = 0x006064.rgbColor
    static let cyanA100: UIColor = 0x84ffff.rgbColor
    static let cyanA200: UIColor = 0x18ffff.rgbColor
    static let cyanA400: UIColor = 0x00e5ff.rgbColor
    static let cyanA700: UIColor = 0x00b8d4.rgbColor
    
    // MARK:- Teal
    static let teal50: UIColor   = 0xe0f2f1.rgbColor
    static let teal100: UIColor  = 0xb2dfdb.rgbColor
    static let teal200: UIColor  = 0x80cbc4.rgbColor
    static let teal300: UIColor  = 0x4db6ac.rgbColor
    static let teal400: UIColor  = 0x26a69a.rgbColor
    static let teal500: UIColor  = 0x009688.rgbColor
    static let teal600: UIColor  = 0x00897b.rgbColor
    static let teal700: UIColor  = 0x00796b.rgbColor
    static let teal800: UIColor  = 0x00695c.rgbColor
    static let teal900: UIColor  = 0x004d40.rgbColor
    static let tealA100: UIColor = 0xa7ffeb.rgbColor
    static let tealA200: UIColor = 0x64ffda.rgbColor
    static let tealA400: UIColor = 0x1de9b6.rgbColor
    static let tealA700: UIColor = 0x00bfa5.rgbColor
    
    // MARK:- Green
    static let green50: UIColor   = 0xd0f8ce.rgbColor
    static let green100: UIColor  = 0xa3e9a4.rgbColor
    static let green200: UIColor  = 0x72d572.rgbColor
    static let green300: UIColor  = 0x42bd41.rgbColor
    static let green400: UIColor  = 0x2baf2b.rgbColor
    static let green500: UIColor  = 0x259b24.rgbColor
    static let green600: UIColor  = 0x0a8f08.rgbColor
    static let green700: UIColor  = 0x0a7e07.rgbColor
    static let green800: UIColor  = 0x056f00.rgbColor
    static let green900: UIColor  = 0x0d5302.rgbColor
    static let greenA100: UIColor = 0xa2f78d.rgbColor
    static let greenA200: UIColor = 0x5af158.rgbColor
    static let greenA400: UIColor = 0x14e715.rgbColor
    static let greenA700: UIColor = 0x12c700.rgbColor
    
    // MARK:- Light Green
    static let lightGreen50: UIColor   = 0xf1f8e9.rgbColor
    static let lightGreen100: UIColor  = 0xdcedc8.rgbColor
    static let lightGreen200: UIColor  = 0xc5e1a5.rgbColor
    static let lightGreen300: UIColor  = 0xaed581.rgbColor
    static let lightGreen400: UIColor  = 0x9ccc65.rgbColor
    static let lightGreen500: UIColor  = 0x8bc34a.rgbColor
    static let lightGreen600: UIColor  = 0x7cb342.rgbColor
    static let lightGreen700: UIColor  = 0x689f38.rgbColor
    static let lightGreen800: UIColor  = 0x558b2f.rgbColor
    static let lightGreen900: UIColor  = 0x33691e.rgbColor
    static let lightGreenA100: UIColor = 0xccff90.rgbColor
    static let lightGreenA200: UIColor = 0xb2ff59.rgbColor
    static let lightGreenA400: UIColor = 0x76ff03.rgbColor
    static let lightGreenA700: UIColor = 0x64dd17.rgbColor
    
    // MARK:- Lime
    static let lime50: UIColor   = 0xf9fbe7.rgbColor
    static let lime100: UIColor  = 0xf0f4c3.rgbColor
    static let lime200: UIColor  = 0xe6ee9c.rgbColor
    static let lime300: UIColor  = 0xdce775.rgbColor
    static let lime400: UIColor  = 0xd4e157.rgbColor
    static let lime500: UIColor  = 0xcddc39.rgbColor
    static let lime600: UIColor  = 0xc0ca33.rgbColor
    static let lime700: UIColor  = 0xafb42b.rgbColor
    static let lime800: UIColor  = 0x9e9d24.rgbColor
    static let lime900: UIColor  = 0x827717.rgbColor
    static let limeA100: UIColor = 0xf4ff81.rgbColor
    static let limeA200: UIColor = 0xeeff41.rgbColor
    static let limeA400: UIColor = 0xc6ff00.rgbColor
    static let limeA700: UIColor = 0xaeea00.rgbColor
    
    // MARK:- Yellow
    static let yellow50: UIColor   = 0xfffde7.rgbColor
    static let yellow100: UIColor  = 0xfff9c4.rgbColor
    static let yellow200: UIColor  = 0xfff59d.rgbColor
    static let yellow300: UIColor  = 0xfff176.rgbColor
    static let yellow400: UIColor  = 0xffee58.rgbColor
    static let yellow500: UIColor  = 0xffeb3b.rgbColor
    static let yellow600: UIColor  = 0xfdd835.rgbColor
    static let yellow700: UIColor  = 0xfbc02d.rgbColor
    static let yellow800: UIColor  = 0xf9a825.rgbColor
    static let yellow900: UIColor  = 0xf57f17.rgbColor
    static let yellowA100: UIColor = 0xffff8d.rgbColor
    static let yellowA200: UIColor = 0xffff00.rgbColor
    static let yellowA400: UIColor = 0xffea00.rgbColor
    static let yellowA700: UIColor = 0xffd600.rgbColor
    
    // MARK:- Amber
    static let amber50: UIColor   = 0xfff8e1.rgbColor
    static let amber100: UIColor  = 0xffecb3.rgbColor
    static let amber200: UIColor  = 0xffe082.rgbColor
    static let amber300: UIColor  = 0xffd54f.rgbColor
    static let amber400: UIColor  = 0xffca28.rgbColor
    static let amber500: UIColor  = 0xffc107.rgbColor
    static let amber600: UIColor  = 0xffb300.rgbColor
    static let amber700: UIColor  = 0xffa000.rgbColor
    static let amber800: UIColor  = 0xff8f00.rgbColor
    static let amber900: UIColor  = 0xff6f00.rgbColor
    static let amberA100: UIColor = 0xffe57f.rgbColor
    static let amberA200: UIColor = 0xffd740.rgbColor
    static let amberA400: UIColor = 0xffc400.rgbColor
    static let amberA700: UIColor = 0xffab00.rgbColor
    
    // MARK:- Orange
    static let orange50: UIColor   = 0xfff3e0.rgbColor
    static let orange100: UIColor  = 0xffe0b2.rgbColor
    static let orange200: UIColor  = 0xffcc80.rgbColor
    static let orange300: UIColor  = 0xffb74d.rgbColor
    static let orange400: UIColor  = 0xffa726.rgbColor
    static let orange500: UIColor  = 0xff9800.rgbColor
    static let orange600: UIColor  = 0xfb8c00.rgbColor
    static let orange700: UIColor  = 0xf57c00.rgbColor
    static let orange800: UIColor  = 0xef6c00.rgbColor
    static let orange900: UIColor  = 0xe65100.rgbColor
    static let orangeA100: UIColor = 0xffd180.rgbColor
    static let orangeA200: UIColor = 0xffab40.rgbColor
    static let orangeA400: UIColor = 0xff9100.rgbColor
    static let orangeA700: UIColor = 0xff6d00.rgbColor
    
    // MARK:- Deep Orange
    static let deepOrange50: UIColor   = 0xfbe9e7.rgbColor
    static let deepOrange100: UIColor  = 0xffccbc.rgbColor
    static let deepOrange200: UIColor  = 0xffab91.rgbColor
    static let deepOrange300: UIColor  = 0xff8a65.rgbColor
    static let deepOrange400: UIColor  = 0xff7043.rgbColor
    static let deepOrange500: UIColor  = 0xff5722.rgbColor
    static let deepOrange600: UIColor  = 0xf4511e.rgbColor
    static let deepOrange700: UIColor  = 0xe64a19.rgbColor
    static let deepOrange800: UIColor  = 0xd84315.rgbColor
    static let deepOrange900: UIColor  = 0xbf360c.rgbColor
    static let deepOrangeA100: UIColor = 0xff9e80.rgbColor
    static let deepOrangeA200: UIColor = 0xff6e40.rgbColor
    static let deepOrangeA400: UIColor = 0xff3d00.rgbColor
    static let deepOrangeA700: UIColor = 0xdd2c00.rgbColor
    
    // MARK:- Brown
    static let brown50: UIColor  = 0xefebe9.rgbColor
    static let brown100: UIColor = 0xd7ccc8.rgbColor
    static let brown200: UIColor = 0xbcaaa4.rgbColor
    static let brown300: UIColor = 0xa1887f.rgbColor
    static let brown400: UIColor = 0x8d6e63.rgbColor
    static let brown500: UIColor = 0x795548.rgbColor
    static let brown600: UIColor = 0x6d4c41.rgbColor
    static let brown700: UIColor = 0x5d4037.rgbColor
    static let brown800: UIColor = 0x4e342e.rgbColor
    static let brown900: UIColor = 0x3e2723.rgbColor
    
    // MARK:- Grey
    static let grey50: UIColor  = 0xfafafa.rgbColor
    static let grey100: UIColor = 0xf5f5f5.rgbColor
    static let grey200: UIColor = 0xeeeeee.rgbColor
    static let grey300: UIColor = 0xe0e0e0.rgbColor
    static let grey400: UIColor = 0xbdbdbd.rgbColor
    static let grey500: UIColor = 0x9e9e9e.rgbColor
    static let grey600: UIColor = 0x757575.rgbColor
    static let grey700: UIColor = 0x616161.rgbColor
    static let grey800: UIColor = 0x424242.rgbColor
    static let grey900: UIColor = 0x212121.rgbColor
    
    // MARK:- Blue Grey
    static let blueGrey50: UIColor  = 0xeceff1.rgbColor
    static let blueGrey100: UIColor = 0xcfd8dc.rgbColor
    static let blueGrey200: UIColor = 0xb0bec5.rgbColor
    static let blueGrey300: UIColor = 0x90a4ae.rgbColor
    static let blueGrey400: UIColor = 0x78909c.rgbColor
    static let blueGrey500: UIColor = 0x607d8b.rgbColor
    static let blueGrey600: UIColor = 0x546e7a.rgbColor
    static let blueGrey700: UIColor = 0x455a64.rgbColor
    static let blueGrey800: UIColor = 0x37474f.rgbColor
    static let blueGrey900: UIColor = 0x263238.rgbColor
}
