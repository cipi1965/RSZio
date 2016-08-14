//
//  RSZio.swift
//  RSZio
//
//  Created by Matteo Piccina on 12/08/16.
//  Copyright © 2016 Matteo Piccina. All rights reserved.
//

import UIKit
import Alamofire

public struct ImageInfo {
    let width : NSNumber
    let height : NSNumber
    let size : NSNumber
    let mimetype : String
}

public class RSZio: NSObject {
    var originalURL : NSURL?
    private var _builder : RSZURLBuilder? = nil
    var builder : RSZURLBuilder? {
        get {
            if _builder == nil && originalURL != nil {
                _builder = RSZURLBuilder(withUrl: originalURL)
            }
            return _builder
        }
    }
    
    init(withUrl URL : NSURL?) {
        self.originalURL = URL
        if URL != nil {
            self._builder = RSZURLBuilder(withUrl: URL);
        }
        super.init()
    }
    convenience override init() {
        self.init(withUrl:nil)
    }
    
    public func buildURL(builderFunc : (builder : RSZURLBuilder) -> RSZURLBuilder) throws -> RSZio {
        guard builder != nil else { throw RSZioErrors.NoURLProvided }
        _builder = builderFunc(builder: self.builder!)
        return self
    }
    
    public func imageAsync(callback : (image : UIImage) -> Void, callbackError : (error : NSError) -> Void) throws {
        guard builder != nil else { throw RSZioErrors.NoURLProvided }
        Alamofire.request(.GET, try! self.builder!.get()).response { (request, response, data, error) in
            if error != nil {
                callbackError(error: error!)
            } else {
                callback(image: UIImage(data: data!)!)
            }
        }
    }
    
    public func imageInfoAsync(callback : (imageinfo : ImageInfo) -> Void, callbackError : (error : NSError) -> Void) throws {
        guard builder != nil else { throw RSZioErrors.NoURLProvided }
        try! self.buildURL { (builder) -> RSZURLBuilder in return builder.imageInfo() }
        Alamofire.request(.GET, try! self.builder!.get()).responseJSON { response in
            switch response.result {
                case .Success(let JSON):
                    let parsedDictionary = JSON as! NSDictionary
                    print(String(format: "%@", parsedDictionary))
                    callback(imageinfo: ImageInfo(width: parsedDictionary["width"] as! NSNumber, height: parsedDictionary["height"] as! NSNumber, size: parsedDictionary["size"] as! NSNumber, mimetype: parsedDictionary["format"] as! String))
                case .Failure(let error):
                    callbackError(error: error)
            }
        }
    }
    
    public func builtURL() throws -> NSURL {
        guard builder != nil else { throw RSZioErrors.NoURLProvided }
        return try! builder!.get()
    }
}
