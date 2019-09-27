//
//  SecondViewController.swift
//  Example17
//
//  Created by Dhanush S on 04/06/19.
//  Copyright © 2019 Dhanush S. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    var coreDataObject = coreDataFunction()
    
    @IBOutlet weak var cartButton: UIBarButtonItem!
    @IBOutlet weak var secondBookName : UILabel!
    @IBOutlet weak var secondBookCount : UILabel!
    @IBOutlet weak var secondBookPrice : UILabel!
    @IBOutlet weak var secondBookImage : UIImageView!

    // storing the detailed value temporaririly
    var dtbkCount : Int = 0
    var dtbkPrice : Int = 0
    var dtbkName : String = ""
    var dtbkImage = UIImage()
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        secondBookName.text = dtbkName
        secondBookCount.text = String(dtbkCount)
        secondBookPrice.text =  String(dtbkPrice)
        secondBookImage.image = dtbkImage
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func addtoCart(_ sender: Any)
    {
         if let obj = coreDataObject.getRequiredBookItem(name: dtbkName)
         {
            if(obj.bookcountc < 1)
            {
                cartButton.isEnabled = false
                //if the count is less than 1 then give a alert message that item not found
                print("Out of Stack")
                let alertController = UIAlertController(title: "Alert", message:"This Item is out of stack", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: .default))
                self.present(alertController, animated: true, completion: nil)
            
            }
            else
            {
                // if is above 0n then insert to cart list and decrement count in booklist
                dtbkCount = 1
                coreDataObject.addList_CartItem(cartname: dtbkName, cartcount: dtbkCount, cartprice: dtbkPrice, cartimage:coreDataObject.convertImagetoData(images: dtbkImage))
                //  update a data in the BookList by using Update Function
                update(name : dtbkName)
                // alert message display
                print("Item added to cart")
//                let alertController = UIAlertController(title: "", message:"Item Added to Cart", preferredStyle: .alert)
//                alertController.addAction(UIAlertAction(title: "Ok", style: .default))
//                self.present(alertController, animated: true, completion: nil)
                //count update in a second view controller
                secondBookCount.text = String(obj.bookcountc)
            }
        }
        
    }
    
    // update the count value for the resoective row
    func update(name: String)  {
        if let cartObj = coreDataObject.getRequiredBookItem(name: name){
            if(cartObj.bookcountc != 0)
            {
                // decrement the perticular items count by 1
                cartObj.bookcountc = cartObj.bookcountc - 1
            }
            else
            {
                cartObj.bookcountc = 0
            }
            coreDataObject.saveBookItem()        }

    }

}
