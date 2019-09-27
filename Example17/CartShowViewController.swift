//
//  CartShowViewController.swift
//  Example17
//
//  Created by Dhanush S on 04/06/19.
//  Copyright © 2019 Dhanush S. All rights reserved.
//

import UIKit

class CartShowViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    var coreDataObject = coreDataFunction()
     var cartObject : [CartList]?
    var bookName1 = [String]()
    var bookCount1 = [Int]()
    var bookPrice1 = [Int]()
    var bookImage1 = [Data]()
    
    @IBOutlet weak var buy: UIBarButtonItem!
    func resetcartData()
    {
        bookName1.removeAll()
        bookCount1.removeAll()
        bookPrice1.removeAll()
        bookImage1.removeAll()
    }
    @IBOutlet weak var cartTableView: UITableView!
    func loadcartProduct()
    {
        
        if let cartitems = coreDataObject.getList_CartItems()
        {
            resetcartData()
             cartObject = cartitems
            for carts in cartObject!
            {
                bookName1.append(carts.cartname!)
                bookCount1.append(Int(carts.cartcount))
                bookPrice1.append(Int(carts.cartprice))
                bookImage1.append(carts.cartimage!)
            }
        }
        cartTableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookName1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cartViewCell = tableView.dequeueReusableCell(withIdentifier: "cartcell", for: indexPath) as! CartShowTableViewCell
        cartViewCell.cartshowName.text = bookName1[indexPath.row]
        cartViewCell.cartshowCount.text = String(bookCount1[indexPath.row])
        cartViewCell.cartshowPrice.text = String(bookPrice1[indexPath.row])
        cartViewCell.cartshowImage.image = UIImage(data: bookImage1[indexPath.row])
        return cartViewCell
    }
    
    override func viewDidLoad() {
        cartTableView.reloadData()
        super.viewDidLoad()
        loadcartProduct()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadcartProduct()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func proceedButton(sender : Any)
    {
        // if no items in cart then checkout controller will not open
        if(bookName1.count == 0)
        {
            buy.isEnabled = false
            let alertController = UIAlertController(title: "Alert", message:"Add Items to cart to Proceed", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alertController, animated: true, completion: nil)
        }
            // it will open next view controller only when there is a item in the cart
        else
        {
            let checkoutView = storyboard?.instantiateViewController(withIdentifier: "checkout") as! CheckOutViewController
            self.navigationController?.pushViewController(checkoutView, animated: true)
        }
        
    }


}
