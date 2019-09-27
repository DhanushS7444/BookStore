//
//  CheckOutViewController.swift
//  Example17
//
//  Created by Dhanush S on 04/06/19.
//  Copyright © 2019 Dhanush S. All rights reserved.
//

import UIKit

class CheckOutViewController: UIViewController {
    var grandTotal : Int = 0
    var coreDataObject = coreDataFunction()
    @IBOutlet weak var grandamount : UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // geting a cart object and taking the total amount and displaying it
       if let checkOutItems = coreDataObject.getList_CartItems()
       {
            for amount in checkOutItems
            {
                grandTotal = grandTotal + Int(amount.cartprice)
            }
        }
        grandamount.text = String(grandTotal)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
// confirming an order so that the cart item should become empty and show the pop up notifiaction as order placed
    @IBAction func checkOut(_ sender: Any) {
        coreDataObject.deleteCartItem()
        print("cart items are deleted")
        let alertController = UIAlertController(title: "Order Placed", message:"Thank you for Purchase!", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        self.present(alertController, animated: true, completion: nil)
        grandamount.text = String(00)
    }
   // back to home using a buttom
    @IBAction func backHome(_ sender: Any) {
        //object of First Table View Controller 
        let backhome : FirstTableViewController = self.navigationController?.childViewControllers[0] as! FirstTableViewController
        self.navigationController?.popToViewController(backhome, animated: true)
    }
    
}
