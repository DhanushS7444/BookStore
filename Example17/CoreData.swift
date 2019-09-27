//
//  CoreData.swift
//  Example17
//
//  Created by Dhanush S on 04/06/19.
//  Copyright © 2019 Dhanush S. All rights reserved.
//

import Foundation
import CoreData
import UIKit

// core data function related to the CRUD functions
class coreDataFunction {
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    var context: NSManagedObjectContext {
        return appDelegate.persistentContainer.viewContext
    }
    
    
    // Function to add dara to the BookList Core Data
    func addList_BookData(name : String, count : Int , price : Int, image : Data)
    {
            if let bookItem = NSEntityDescription.insertNewObject(forEntityName: "BookList", into: context) as? BookList {
            bookItem.booknamec = name
            bookItem.bookimagec = image
            bookItem.bookcountc = Int16(count)
            bookItem.bookpricec = Int16(price)
            appDelegate.saveContext()
         }
    }
    
    // Functions to add data or cart item to the CartList
        func addList_CartItem(cartname : String, cartcount : Int, cartprice : Int, cartimage : Data )
        {
            if let cartItem = NSEntityDescription.insertNewObject(forEntityName: "CartList", into: context) as? CartList
            {
                cartItem.cartname = cartname
                cartItem.cartcount = Int16(cartcount)
                cartItem.cartimage = cartimage
                cartItem.cartprice = Int16(cartprice)
                appDelegate.saveContext()
            }
        
        }
    
    // get BookList Data bu using this function
        
        func getList_BookItems() -> [BookList]? {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "BookList")
            if let recentBook = try? context.fetch(fetchRequest) as? [BookList] {
                return recentBook
            }
            return nil
        }
    
    
    //get CartList Data by using this Function
        func getList_CartItems() -> [CartList]?
        {
            let fatchcart = NSFetchRequest<NSFetchRequestResult>(entityName: "CartList")
            if let recentCart = try? context.fetch(fatchcart) as? [CartList] {
                return recentCart
            }
            return nil
            
        }
    
    // get a perticular row in the core data by sending the ItemName
        
            func getRequiredBookItem(name: String) -> BookList?
            {
                let cartFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "BookList")
                cartFetchRequest.predicate = NSPredicate(format: "booknamec == %@", name)
                if let select = try? context.fetch(cartFetchRequest) as? [BookList]{
                    return select?.first
                }
                return nil
          
        }
    
    
    // converting the image from UIImage format to the Data Format
    
    func convertImagetoData(images : UIImage) -> Data
    {
        let imageData : NSData = UIImagePNGRepresentation(images)! as NSData 
        return imageData as Data
    }
    
    
    // Delete the cart data once its got checked out order confirmed
    // to cleam the cart view controller
    
    func deleteCartItem()
    {
        let cartFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CartList")
        let carts = try? context.fetch(cartFetchRequest) as? [CartList]
        let cartObjc = carts
        if let count = cartObjc?!.count{
            for i in 0..<count{
                context.delete(cartObjc!![i])
                appDelegate.saveContext()
            }
        }
        
    }
    
    // saving the data to the core Data after updation of Bookcount Data
    
    func saveBookItem()
    {
    appDelegate.saveContext()
    }

}
