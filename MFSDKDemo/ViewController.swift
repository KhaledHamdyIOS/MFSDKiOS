//
//  ViewController.swift
//  MFSDKDemo
//
//  Created by Elsayed Hussein on 10/10/18.
//  Copyright © 2018 MyFatoorah. All rights reserved.
//

import UIKit
import MFSDK

class ViewController: UIViewController {
    
    @IBOutlet weak var errorcodeLabel : UILabel!
    @IBOutlet weak var resultLabel : UILabel!
    @IBOutlet weak var payVISA_Button: UIButton!
    @IBOutlet weak var payKNET_Button: UIButton!
    @IBOutlet weak var pay_Button: UIButton!
    
    // customer details
    let customer = MFCustomer()
    
    //at list one prodduct Required
    let productList = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set order status delegate Method to get payment status
        MFOrderStatusRequest.sharedInstance.delegateOrderStatus = self
        
        customer.customerName = "customer name " //Required
        customer.customerEmailAddress = "email address"//Required
        customer.customerMobileNo = "mobile no"//Required
        customer.customerGender = ""
        customer.customerDOB = ""
        customer.customerCivilID = ""
        customer.customerArea = ""
        customer.customerBlockNo = ""
        customer.customerStreet = ""
        customer.customerAvenue = ""
        customer.customerBuildingNo = ""
        customer.customerFloorNo = ""
        customer.customerApartment = ""
        
        for _ in 0..<5 {
            
            // MFProduct Details
            let product = MFProductDetails()
            
            product.productName = "ABC"
            product.productPrice = 0.145
            product.productQuntity = 4
            
            productList.add(product)
        }
    }
    
    @IBAction func payVISADidPRessed(_ sender: AnyObject){
        
        //place order with SDK
        MFPaymentRequest.sharedInstance.payfor_VISA(customer: customer, productList: productList, subTotal: 0.725, paymentCurrrency: "KWD")
        
    }
    
    @IBAction func payKNETDidPRessed(_ sender: Any) {
        
        //place order with SDK
        MFPaymentRequest.sharedInstance.payfor_KNET(customer: customer, productList: productList, subTotal: 0.725, paymentCurrrency: "KWD")
    }
    
    @IBAction func payDidPRessed(_ sender: Any) {
        
        //place order with SDK
        MFPaymentRequest.sharedInstance.payfor_BOTH(customer: customer, productList: productList, subTotal: 0.725, paymentCurrrency: "KWD")
    }
    
}
//MFOrder status Delegate methods
extension ViewController : MFOrderStatusRequestDelegate {
    
    func getOrderPaymentStatusSucess(ordetStatus: MFOrderStatusRequestResponse) {
        DispatchQueue.main.async(execute: {
            
            self.errorcodeLabel.text = String(format: "responseCode: %@", ordetStatus.responseCode)
            
            self.resultLabel.text = String(format: "result: %@",ordetStatus.result)
            
        })
    }
    
    
    
    func getOrderPaymentStatusFailed(ordetStatus:MFOrderStatusRequestResponse) {
        DispatchQueue.main.async(execute: {
            
            self.errorcodeLabel.text = String(format: "responseCode: %@", ordetStatus.responseCode)
            self.resultLabel.text = String(format: "result: %@",ordetStatus.result)
            
        })
    }
}
