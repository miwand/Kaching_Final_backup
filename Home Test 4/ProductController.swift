//
//  ProductController.swift
//  Home Test 4
//
//  Created by Miwand Najafe on 2015-10-05.
//  Copyright © 2015 Alexander Besson. All rights reserved.
//

import UIKit

class ProductController {

    
    var products = [Parse_ProductModel]()
//    var itemImages = [UIImage]()
    
    func fetchParseData (callBack:([Parse_ProductModel]?, NSError?) -> Void ) -> Void {
        let query = PFQuery(className: "ItemList")
        query.findObjectsInBackgroundWithBlock { (productsArray, error) -> Void in
            
            guard error == nil else {
                               callBack(nil, error)
                print("That Failed")
                return
            }
            guard let actualProducts = productsArray else {
                print("This failed")
                                callBack(nil, nil)
                
                return
            }
            
            self.products.removeAll()
            for parseProduct in actualProducts {
                
                
                
                
                
                guard let retailPriceFloat = parseProduct.objectForKey("RetailPrice") as? Float else {
                    return
                }
                guard let itemName = parseProduct.objectForKey("ItemName") as? String else {
                    return
                }
                guard let discountPriceFloat = parseProduct.objectForKey("DiscountPrice") as? Float else {
                    return
                }
                guard let threshold = parseProduct.objectForKey("Threshold") as? Float else {
                    return
                }
                guard let currentCommit = parseProduct.objectForKey("CurrentCommit") as? Float else {
                    return
                }
                guard let itemImagePFFile = parseProduct.objectForKey("ItemImage") as? PFFile else {
                    return
                }
                
//                itemImagePFFile.getDataInBackgroundWithBlock({ (imageData: NSData?, error:NSError?) -> Void in
//                    if (error == nil) {
//                        guard let itemimage = UIImage(data: imageData!) else {
//                            print("No image found")
//                            return
//                        }
//                        
//                        self.itemImages.append(itemimage)
//                    }
//               })
                
                
                let discountPriceString = String(format: "%.2f", discountPriceFloat)
                let retailPriceString = String(format: "%.2f", retailPriceFloat)
                //                self.products.append(product)
                self.products += [Parse_ProductModel(itemName: itemName, currentCommit: currentCommit , threshold: threshold, retailPrice: retailPriceString, discountPrice: discountPriceString)]
                
                
            }
            callBack(self.products, nil)
        }
        
        
    }
}

    

