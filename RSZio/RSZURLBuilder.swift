//
//  RSZURLBuilder.swift
//  RSZio
//
//  Created by Matteo Piccina on 12/08/16.
//  Copyright © 2016 Matteo Piccina. All rights reserved.
//

import UIKit

struct QueryPart {
    var key : String
    var value : String
}

public class RSZURLBuilder : NSObject {
    var originalURL : NSURL?
    var requests : [QueryPart] = []
    
    init(withUrl URL : NSURL?) {
        self.originalURL = URL
        super.init()
    }
    convenience override init() {
        self.init(withUrl:nil)
    }
    private func buildURL() -> NSURL {
        let oldUrlComponents = NSURLComponents(URL: self.originalURL!, resolvingAgainstBaseURL: false)
        
        oldUrlComponents!.host = oldUrlComponents!.host! + ".rsz.io"
        if oldUrlComponents!.query != nil && oldUrlComponents!.query != "" {
            let percentEscapedQuery : String! = ("?" + oldUrlComponents!.query!).stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet(charactersInString: "?=&").invertedSet)
            oldUrlComponents!.path = oldUrlComponents!.path! + percentEscapedQuery
        }
        
        var RSZioQuery = ""
        for (index, request) in requests.enumerate() {
            if index != 0 {
                RSZioQuery += "&"
            }
            RSZioQuery += String(format: "%@=%@", request.key, request.value)
        }
        
        oldUrlComponents?.query = RSZioQuery != "" ? RSZioQuery : nil
        
        return (oldUrlComponents?.URL)!
    }
    
    // Credits to yeahdongcn for this function
    private func hexByColor(color : UIColor) -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        color.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        return String(format: "#%02X%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255), Int(a * 255))
    }
    
    private func addToRequests(key : String!, value : String!) {
        var found : Bool = false
        for (index, request) in requests.enumerate() {
            if request.key == key {
                requests[index].value = value
                found = true
            }
        }
        if !found {
            requests.append(QueryPart(key: key, value: value))
        }
    }
    
    public func get() throws -> NSURL {
        if (self.originalURL == nil) {
            throw RSZURLBuilderErrors.NoURLProvided
        }
        
        return buildURL()
    }
    
    public func width(width : Int, percentage : Bool = false) -> RSZURLBuilder {
        addToRequests("width", value: (percentage ? String(width)+"%" : String(width)))
        return self
    }
    
    public func height(height : Int, percentage : Bool = false) -> RSZURLBuilder {
        addToRequests("height", value: (percentage ? String(height)+"%" : String(height)))
        return self
    }
    
    public func mode(mode : RSZioResizeMode) -> RSZURLBuilder {
        addToRequests("mode", value: mode.rawValue)
        return self
    }
    
    public func scale(scale : RSZioResizeScale) -> RSZURLBuilder {
        addToRequests("scale", value: scale.rawValue)
        return self
    }
    
    public func anchor(anchor : RSZioResizeAnchor) -> RSZURLBuilder {
        addToRequests("anchor", value: anchor.rawValue)
        return self
    }
    
    public func cropHintX(value : Int, percentage : Bool = false) -> RSZURLBuilder {
        addToRequests("crop-hint-x", value: (percentage ? String(value)+"%" : String(value)))
        return self
    }
    
    public func cropHintY(value : Int, percentage : Bool = false) -> RSZURLBuilder {
        addToRequests("crop-hint-y", value: (percentage ? String(value)+"%" : String(value)))
        return self
    }
    
    public func rotate(angle : Int) -> RSZURLBuilder {
        addToRequests("rotate", value: String(angle))
        return self
    }
    
    public func srotate(angle : Int) -> RSZURLBuilder {
        addToRequests("srotate", value: String(angle))
        return self
    }
    
    public func flip(axes : RSZioFlipAxes) -> RSZURLBuilder {
        addToRequests("flip", value: axes.rawValue)
        return self
    }
    
    public func sflip(axes : RSZioFlipAxes) -> RSZURLBuilder {
        addToRequests("sflip", value: axes.rawValue)
        return self
    }
    
    public func affine(a : Float!, b : Float!, c : Float!, d : Float!, dx : Int!, dy : Int!) -> RSZURLBuilder {
        addToRequests("affine", value: String(format: "%@,%@,%@,%@,%@,%@", a, b, c, d, dx, dy))
        return self
    }
    
    public func affine(a : Float!, b : Float!, c : Float!, d : Float!, dx : Int!, dy : Int!, ow : Int!, oh : Int!, ox : Int!, oy : Int!) -> RSZURLBuilder {
        addToRequests("affine", value: String(format: "%@,%@,%@,%@,%@,%@,%@,%@,%@,%@", a, b, c, d, dx, dy, ow, oh, ox, oy))
        return self
    }
    
    public func interpolation(method : RSZioInterpolation) -> RSZURLBuilder {
        addToRequests("interp", value: method.rawValue)
        return self
    }
    
    public func colorspace(colorspace : RSZioColorspace) -> RSZURLBuilder {
        addToRequests("colorspace", value: colorspace.rawValue)
        return self
    }
    
    public func staged(value : Bool = true) -> RSZURLBuilder {
        addToRequests("staged", value: String(value))
        return self
    }
    
    public func dcmpPresize(value : Bool = true) -> RSZURLBuilder {
        addToRequests("dcmp-presize", value: String(value))
        return self
    }
    
    public func dpLimit(value : Float) -> RSZURLBuilder {
        addToRequests("dp-limit", value: String(value))
        return self
    }
    
    public func downscalePrefilter(value : Bool = true) -> RSZURLBuilder {
        addToRequests("downscale-prefilter", value: String(value))
        return self
    }
    
    public func dpfStrenght(value : Float) -> RSZURLBuilder {
        addToRequests("dpf-strenght", value: String(value))
        return self
    }
    
    public func bgcolor(color : UIColor) -> RSZURLBuilder {
        addToRequests("bgcolor", value: hexByColor(color))
        return self
    }
    
    public func format(format : RSZioFormat) -> RSZURLBuilder {
        addToRequests("format", value: format.rawValue)
        return self
    }
    
    public func quality(value : Int) -> RSZURLBuilder {
        addToRequests("quality", value: String(value))
        return self
    }
    
    public func subsampling(value : RSZioSubsampling) -> RSZURLBuilder {
        addToRequests("subsampling", value: value.rawValue)
        return self
    }
    
    public func blur(value : Int) -> RSZURLBuilder {
        addToRequests("blur", value: String(value))
        return self
    }
    
    public func histNorm(value : Bool = true) -> RSZURLBuilder {
        addToRequests("hist-norm", value: String(value))
        return self
    }
    
    public func histEqual(value : Int) -> RSZURLBuilder {
        addToRequests("hist-equal", value: String(value))
        return self
    }
    
    public func sharpen() {
        //TODO
    }
    
    public func gamma(value : Float) -> RSZURLBuilder {
        addToRequests("gamma", value: String(value))
        return self
    }
    
    public func brightness(value : Float) -> RSZURLBuilder {
        addToRequests("luminance", value: String(value))
        return self
    }
    
    public func brightness(value : Float, value2 : Float) -> RSZURLBuilder {
        addToRequests("luminance", value: String(format: "%f,%f", value, value2))
        return self
    }
    
    public func chroma(value : Float) -> RSZURLBuilder {
        addToRequests("chroma", value: String(value))
        return self
    }
    
    public func chroma(value : Float, value2 : Float) -> RSZURLBuilder {
        addToRequests("chroma", value: String(format: "%f,%f", value, value2))
        return self
    }
    
    public func hue(value : Float) -> RSZURLBuilder {
        addToRequests("hue", value: String(value))
        return self
    }
    
    public func hue(value : Float, value2 : Float) -> RSZURLBuilder {
        addToRequests("hue", value: String(format: "%f,%f", value, value2))
        return self
    }
    
    public func colorMatrix() {
        //TODO
    }
    
    public func daltonize(mode : RSZioDaltonizationFilters) -> RSZURLBuilder {
        addToRequests("daltonize", value: mode.rawValue)
        return self
    }
    
    public func sepia() -> RSZURLBuilder {
        addToRequests("sepia", value: "true")
        return self
    }
    
    public func bwPhoto() -> RSZURLBuilder {
        addToRequests("bw-photo", value: "true")
        return self
    }
    
    public func polaroid() -> RSZURLBuilder {
        addToRequests("polaroid", value: "true")
        return self
    }
    
    public func invert() -> RSZURLBuilder {
        addToRequests("invert", value: "true")
        return self
    }
    
    public func imageInfo() -> RSZURLBuilder {
        addToRequests("image-info", value: "true")
        return self
    }
}