//
//  Constants.swift
//  Assignment_VikramGupta
//
//  Created by Vikram Gupta on 7/23/20.
//  Copyright © 2020 Vikram Gupta. All rights reserved.
//

import Foundation
import UIKit

// Base Url
let baseURL = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/"

enum ApiError: String, Error{
    case inValidResponse = "InValid response"
    case networkNotAvilable = "You are currently offline."
    case parsingError = "Invalid json"
}

//Api name
enum ApiName: String {
    case facts = "facts.json"
}

enum Message: String {
  case header = "Alert"
}

// Screen Height & Width
let WIDTH = UIScreen.main.bounds.size.width
let HEIGHT = UIScreen.main.bounds.size.height

let WIDTH_FACTOR: CGFloat = WIDTH/320.0
let HEIGHT_FACTOR : CGFloat = HEIGHT/568.0

let FontFactor : CGFloat = WIDTH/320.0


//Font name and size
let Font_Helvetica_Neue  = "HelveticaNeue"

let FONT_SIZE_3  : CGFloat      = 3 * FontFactor
let FONT_SIZE_4  : CGFloat      = 4 * FontFactor
let FONT_SIZE_5  : CGFloat      = 5 * FontFactor
let FONT_SIZE_6  : CGFloat      = 6 * FontFactor
let FONT_SIZE_7  : CGFloat      = 7 * FontFactor
let FONT_SIZE_8  : CGFloat      = 8 * FontFactor
let FONT_SIZE_9  : CGFloat      = 9 * FontFactor
let FONT_SIZE_10 : CGFloat      = 10 * FontFactor
let FONT_SIZE_11 : CGFloat      = 11 * FontFactor
let FONT_SIZE_12 : CGFloat      = 12 * FontFactor
let FONT_SIZE_13 : CGFloat      = 13 * FontFactor
let FONT_SIZE_14 : CGFloat      = 14 * FontFactor
let FONT_SIZE_15 : CGFloat      = 15 * FontFactor
let FONT_SIZE_16 : CGFloat      = 16 * FontFactor
let FONT_SIZE_17 : CGFloat      = 17 * FontFactor
let FONT_SIZE_18 : CGFloat      = 18 * FontFactor
let FONT_SIZE_19 : CGFloat      = 19 * FontFactor
let FONT_SIZE_20 : CGFloat      = 20 * FontFactor
let FONT_SIZE_21 : CGFloat      = 21 * FontFactor
let FONT_SIZE_22 : CGFloat      = 22 * FontFactor
let FONT_SIZE_23 : CGFloat      = 23 * FontFactor
let FONT_SIZE_24 : CGFloat      = 24 * FontFactor
let FONT_SIZE_25 : CGFloat      = 25 * FontFactor
let FONT_SIZE_26 : CGFloat      = 26 * FontFactor
let FONT_SIZE_27 : CGFloat      = 27 * FontFactor
let FONT_SIZE_28 : CGFloat      = 28 * FontFactor
let FONT_SIZE_29 : CGFloat      = 29 * FontFactor
let FONT_SIZE_30 : CGFloat      = 30 * FontFactor
let FONT_SIZE_31 : CGFloat      = 31 * FontFactor
let FONT_SIZE_32 : CGFloat      = 32 * FontFactor
let FONT_SIZE_34 : CGFloat      = 34 * FontFactor
let FONT_SIZE_36 : CGFloat      = 36 * FontFactor

//Colors
func ColorRGB(r : Float , g : Float , b : Float) -> UIColor{
    return UIColor(red:CGFloat(r/255.0) , green: CGFloat(g/255.0), blue: CGFloat(b/255.0), alpha: 1.0)
}

func titleColor() -> UIColor {
    return ColorRGB(r:0, g:0, b:0)
}

func discriptionColor() -> UIColor {
    return ColorRGB(r: 221,g: 225,b: 228)
}

func darkGrayColor() -> UIColor{
    return ColorRGB(r: 66, g: 79, b: 94)
}

func navigationBarColor() -> UIColor{
    return UIColor.red
}
