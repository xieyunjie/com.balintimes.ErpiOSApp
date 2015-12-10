//
//  CRMCustomerSignFormControllerTableViewController.swift
//  merp
//
//  Created by yunjie Xie on 15/12/7.
//  Copyright © 2015年 balintimes. All rights reserved.
//

import UIKit

protocol CRMCustomerSignFormControllerDelegate{
    func formRequireFieldCheck(finish:Bool);
}

class CRMCustomerSignFormController: UITableViewController,UITextFieldDelegate {

    @IBOutlet weak var txtCustomerName: UITextField!
    @IBOutlet weak var txtCustomerIndustry: UITextField!
    @IBOutlet weak var txtCustomerRegion: UITextField!
    var province:Province?;
    var city:City?;
    @IBOutlet weak var txtCustomerAddress: UITextField!
    @IBOutlet weak var txtCustomerPhone: UITextField!
    @IBOutlet weak var txtCustomerZipCode: UITextField!
    @IBOutlet weak var txtCustomerComment: UITextField!
    
    
    @IBOutlet weak var txtBrandName: UITextField!
    @IBOutlet weak var txtBrandType: UITextField!
    @IBOutlet weak var txtBrandProxyCompany: UITextField!
    @IBOutlet weak var txtBrandIndustry: UITextField!
    @IBOutlet weak var txtBrandAddress: UITextField!
    @IBOutlet weak var txtBarndPhone: UITextField!
    @IBOutlet weak var txtBrandZipCode: UITextField!
    
    var delegate:CRMCustomerSignFormControllerDelegate?;
    
    let txtInputView = UIView(frame: CGRectZero);
    
    private var _cityPicker:CityPickerViewController!;
    
    var cityPicker:CityPickerViewController{
        get{
            if self._cityPicker == nil{
                self._cityPicker = CityPickerViewController();
            }
            return self._cityPicker;
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        if self.delegate == nil{
            return;
        }
        
        if self.txtCustomerName.text!.isEmpty
        || self.txtCustomerIndustry.text!.isEmpty
        || self.txtCustomerRegion.text!.isEmpty {
            self.delegate?.formRequireFieldCheck(false);
            return;
        }
        
        self.delegate?.formRequireFieldCheck(true);        
    } 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.txtCustomerName.delegate = self;
        self.txtCustomerIndustry.delegate = self;
        self.txtCustomerRegion.delegate = self;
        self.txtCustomerRegion.inputView = self.txtInputView;

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.view.endEditing(true);
    }
    override  func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.None;
    }
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if textField == self.txtCustomerRegion{
            self.cityPicker.show(self.parentViewController!, textField, successAction: self.txtCustomerRegionSuccess,cancelAction: nil);
        }
        return true;
    }
    func txtCustomerRegionSuccess(sender:DataPickerViewController,province:Province,city:City){
        
        self.txtCustomerRegion.endEditing(true);
        
        self.txtCustomerRegion.text = "\(province.name!) -> \(city.name!)";
        self.province = province;
        self.city = city;
    }

    @IBAction func btnCopyClick(sender: AnyObject) {
        
    }
    
    func getCustomerAndBrand() -> (customer:Customer,brand:Brand){
        let customer = Customer(), brand = Brand();
        
        customer.name = self.txtCustomerName.text!;
        customer.industry = self.txtCustomerIndustry.text!;
        customer.province = self.province?.name!;
        customer.city = self.city?.name!;
        
        customer.address = self.txtCustomerAddress.text;
        customer.phonenumber = self.txtCustomerPhone.text;
        customer.zipcode = self.txtCustomerZipCode.text;
        customer.zipcode = self.txtCustomerComment.text;
        
        
        return (customer:customer,brand:brand);
    }
    
    func setCustomerAndBrand(customer:Customer,brand:Brand){
        
        
    }
    
    
    
    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
