//
//  FirstTableViewController.swift
//  Example17
//
//  Created by Dhanush S on 04/06/19.
//  Copyright © 2019 Dhanush S. All rights reserved.
//

import UIKit
import CoreData

class FirstTableViewController: UITableViewController {
    
    var context : NSManagedObjectContext?
    var bookObject : [BookList]?
    var bookName = [String]()
    var bookCount = [Int]()
    var bookPrice = [Int]()
    var bookImage = [Data]()
    
    @IBOutlet var FirstTableView: UITableView!
    
    var coreDataObject = coreDataFunction()
    
    
    func resetBookData()
    {
          bookName.removeAll()
          bookCount.removeAll()
          bookPrice.removeAll()
          bookImage.removeAll()
    }
   
    // function to load the data to the Array
   
   func loadListProduct()
   {
    
        if let bookitems = coreDataObject.getList_BookItems()
        {
            resetBookData()
            bookObject = bookitems
            for Books in bookObject!
            {
                bookName.append(Books.booknamec!)
                bookPrice.append(Int(Books.bookpricec))
                bookImage.append(Books.bookimagec!)
                bookCount.append(Int(Books.bookcountc))
            }
        }
    FirstTableView.reloadData()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        FirstTableView.reloadData()
        let appDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        let preload = UserDefaults.standard.bool(forKey: "ONE_TIME_RUN")
        if !preload {
            // adding a data if it is launching for the First time
            coreDataObject.addList_BookData(name: "Swift Programming ", count: 23, price: 10, image: coreDataObject.convertImagetoData(images: #imageLiteral(resourceName: "image1")))
            coreDataObject.addList_BookData(name: "iOS Basics ", count: 12, price: 12, image: coreDataObject.convertImagetoData(images: #imageLiteral(resourceName: "image2")))
            coreDataObject.addList_BookData(name: "Objective-C", count: 41, price: 43, image: coreDataObject.convertImagetoData(images: #imageLiteral(resourceName: "image3")))
            coreDataObject.addList_BookData(name: "Complete iPhone Programming ", count: 5, price: 123, image: coreDataObject.convertImagetoData(images: #imageLiteral(resourceName: "image4")))
            UserDefaults.standard.set(true, forKey: "ONE_TIME_RUN")
        }
        
        // load data to the view by getting an object
        loadListProduct()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadListProduct()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Number of row is the item available in the core data
        return bookName.count
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Cell to Display View
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FirstTableViewCell
        cell.bookNameLabel.text = bookName[indexPath.row]
        cell.bookImage.image = UIImage(data: bookImage[indexPath.row])
        cell.bookPriceLabel.text = String (bookPrice[indexPath.row])
        cell.bookCountLabel.text = String (bookCount[indexPath.row])
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailScene = storyboard?.instantiateViewController(withIdentifier: "DetailScene") as! SecondViewController
        detailScene.dtbkName = bookName[indexPath.row]
        detailScene.dtbkCount = (bookCount[indexPath.row])
        detailScene.dtbkPrice = (bookPrice[indexPath.row])
        detailScene.dtbkImage = UIImage(data : bookImage[indexPath.row])!
       self.navigationController?.pushViewController(detailScene, animated: true)
        // pushing the data to the Second View Controller
    }

    @IBAction func cartTapped(sender : Any)
    {
        // function pushes data to the cartshowViewController
        let cartView = storyboard?.instantiateViewController(withIdentifier: "Cart") as! CartShowViewController
        self.navigationController?.pushViewController(cartView, animated: true)
    }

}
