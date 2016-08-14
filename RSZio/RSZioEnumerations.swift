//
//  RSZioEnumerations.swift
//  RSZio
//
//  Created by Matteo Piccina on 13/08/16.
//  Copyright © 2016 Matteo Piccina. All rights reserved.
//

import Foundation

public enum RSZURLBuilderErrors: ErrorType {
    case NoURLProvided
}

public enum RSZioErrors: ErrorType {
    case NoURLProvided
}

public enum RSZioResizeMode : String {
    case Max        = "max"
    case Pax        = "pax"
    case Crop       = "crop"
    case Stretch    = "stretch"
}

public enum RSZioResizeScale : String {
    case Both   = "both"
    case Down   = "down"
    case Canvas = "canvas"
}

public enum RSZioResizeAnchor : String {
    case TopLeft        = "top-left"
    case TopCenter      = "top-center"
    case TopRight       = "top-right"
    case MiddleLeft     = "middle-left"
    case MiddleCenter   = "middle-center"
    case MiddleRight    = "middle-right"
    case BottomLeft     = "bottom-left"
    case BottomCenter   = "bottom-center"
    case BottomRight    = "bottom-right"
}

public enum RSZioFlipAxes : String {
    case X  = "x"
    case XY = "xy"
    case Y  = "y"
}

public enum RSZioInterpolation : String {
    case Nearest    = "nearest"
    case Bilinear   = "bilinear"
    case Bicubic    = "bicubic"
    case LBB        = "lbb"
    case Nohalo     = "nohalo"
    case VSQBS      = "vsqbs"
}

public enum RSZioColorspace : String {
    case XYZ    = "xyz"
    case Lab    = "lab"
    case Labs   = "labs"
    case LCh    = "lch"
    case RGB    = "rgb"
    case scRGB  = "scrgb"
    case RGB16  = "rgb16"
    case Grey16 = "grey16"
    case Yxy    = "yxy"
}

public enum RSZioFormat : String {
    case JPG = "jpg"
    case PNG = "png"
    case WebP = "webp"
    case BMP = "bmp"
}

public enum RSZioSubsampling : String {
    case s444 = "444"
    case s422 = "422"
    case s420 = "420"
    case Gray = "Gray"
}

public enum RSZioDaltonizationFilters : String {
    case SimProtanopia = "sim-protanopia"
    case SimDeuteranopia = "sim-deuteranopia"
    case SimTritanopia = "sim-tritanopia"
    case AdjProtanopia = "adj-protanopia"
    case AdjDeuteranopia = "adj-deuteranopia"
    case AdjTritanopia = "adj-tritanopia"
}