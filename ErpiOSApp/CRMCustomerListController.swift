//
//  CRMCustomerListController.swift
//  ErpiOSApp
//
//  Created by AlexXie on 15/12/11.
//  Copyright © 2015年 balintimes. All rights reserved.
//

import UIKit

class CRMCustomerListController: UITableViewController,CRMCustomerSignViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1;
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 20;
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("customerCell", forIndexPath: indexPath) as! CustomerCell;
        
        cell.setCellValue(indexPath.row.description);
 
        return cell
    }
    
    private var didSelectCustomer:Customer?
    private var didSelectBrand:Brand?;
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.didSelectBrand = Brand();
        self.didSelectCustomer = Customer();
        self.performSegueWithIdentifier("segueCustomerDetail", sender: tableView);
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let registerAction = UITableViewRowAction(style: .Default, title: "注册申请") { (action: UITableViewRowAction, indexPath:NSIndexPath) -> Void in
            
        }
        registerAction.backgroundColor = UIColor.grayColor();
        
        let saleLogAtion = UITableViewRowAction(style: .Normal, title: "日志") { (action: UITableViewRowAction, indexPath:NSIndexPath) -> Void in
            
        }
        saleLogAtion.backgroundColor = UIColor(red: 0.7, green: 0.35, blue: 0.68, alpha: 1);
        
        let moreAtion = UITableViewRowAction(style: .Normal, title: "更多",handler:self.moreActionClick);
        moreAtion.backgroundColor = UIColor.orangeColor();
        
        return [moreAtion,registerAction,saleLogAtion];
        
    }
    
    private func moreActionClick(action:UITableViewRowAction, indexPath:NSIndexPath){
        
        let actionSheet = UIAlertController(title: "", message: "更多操作", preferredStyle: UIAlertControllerStyle.ActionSheet);
        
        let uploadAttAction = UIAlertAction(title: "附件上传", style: UIAlertActionStyle.Default) { (action) -> Void in
            self.performSegueWithIdentifier("segueCRMAttUpload", sender: self);
        }
        let contractEditAction = UIAlertAction(title: "联系人编辑", style: UIAlertActionStyle.Default) { (action) -> Void in
           self.performSegueWithIdentifier("segueCRMContractEdit", sender: self);
        }
        let deleteAction = UIAlertAction(title: "删除客户", style: UIAlertActionStyle.Destructive) { (action) -> Void in
            print("delete Customer");
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel) { (action) -> Void in
            print("cancel");
        } 
        
        
        actionSheet.addAction(uploadAttAction);
        actionSheet.addAction(contractEditAction);
        actionSheet.addAction(deleteAction);
        actionSheet.addAction(cancelAction);
//        actionSheet.addTextFieldWithConfigurationHandler { (txt:UITextField) -> Void in
//            
//        }
        
        let mainView = actionSheet.view.subviews[0].subviews[0].subviews[0].subviews[0].subviews[0].subviews[2];
        print(mainView);
//        for v in mainView.subviews{
//            print(v);
//        }
        
//        for v in actionSheet.view.subviews{
//            if v.isKindOfClass(UIButton){
//                let b = v as! UIButton;
//                
//                print(b);
//            }
//        }
        
        self.presentViewController(actionSheet, animated: true, completion: nil);
 
    }

    @IBAction func btnBackClick(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil);
    }

    @IBAction func btnAddCustomerClick(sender: AnyObject) {
        
        self.performSegueWithIdentifier("segueCustomerDetail", sender: sender);
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "segueCustomerDetail"{
            let navCtrl = segue.destinationViewController as! UINavigationController;
            let signCtrl = navCtrl.topViewController as! CRMCustomerSignViewController;
            
            signCtrl.editBrand = self.didSelectBrand;
            signCtrl.editCustomer = self.didSelectCustomer;
            signCtrl.delegate = self;
        }
        
    }
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        return true;
    }
    
    // delegate
    
    func saveSuccessful(success: Bool) {
        
        print(success);
        
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view\
    .
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
