//
//  CRMCustomerListController.swift
//  ErpiOSApp
//
//  Created by AlexXie on 15/12/11.
//  Copyright © 2015年 balintimes. All rights reserved.
//

import UIKit

class CRMCustomerListController: UITableViewController,CRMCustomerSignViewControllerDelegate,TableViewFooterLoadMoreViewDelegate {
    
    var tableViewFooter:TableViewFooterLoadMoreView?;
    
    var customerList = Array<Customer>();
    var currentPage = 1;
    var pageSize = 20;
    var total = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        let refreshControl = UIRefreshControl();
        refreshControl.addTarget(self, action: Selector("refresh"), forControlEvents: UIControlEvents.ValueChanged);
        refreshControl.attributedTitle = NSAttributedString(string: "刷新数据 ....");
        self.refreshControl = refreshControl;
        
        self.tableViewFooter = TableViewFooterLoadMoreView.createFooter(CGRectMake(0, 0, self.view.bounds.width, 44), delegate: self);
        tableView.tableFooterView = self.tableViewFooter;
        
        let block = BlockMsg.showLoading(self.view, msg: "正在加载数据...");
        self.loadCustomerList(1) { () -> Void in
            BlockMsg.hideLoading(block);
        }
    }
    
    func loadCustomerList(loadPage:Int,afterLoad:(()->Void)?){
        
        
        let params:[String:AnyObject] = ["page":loadPage,"pagesize":self.pageSize];
        
        RequestApi.post(CrmReq.listUrl.rawValue, params) { (res:ResponseData<Customer>) -> Void in
            
            
            if res.success == true{
                
                if res.list?.count > 0{
                    self.customerList += res.list!;
                    self.total = res.total;
                    self.currentPage = loadPage;
                    
                    self.tableView.reloadData();
                }
            }
            else{
                BlockMsg.showText(self.view, msg: "加载数据失败-\(res.errCode)", afterDelay: 1.5);
            }
            if let al = afterLoad{
                al();
            }
            
        }
        
    }
    
    func refresh(){
        self.currentPage = 1;
        self.total = 0;
        self.loadCustomerList(1, afterLoad: self.refreshControl?.endRefreshing);
    }
    
    func loadMoreBegin(){
        
        if self.total ==  self.customerList.count{
            self.tableViewFooter?.stopLoading();
            return;
        }
        
        self.loadCustomerList(self.currentPage + 1 , afterLoad: self.tableViewFooter?.stopLoading);
        
        
        //        print("begin load");
        //        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(2.0 * Double(NSEC_PER_SEC)));
        //
        //
        //        dispatch_after(time,dispatch_get_main_queue() , { () -> Void in
        //            self.tableViewFooter?.stopLoading();
        //            print("end load");
        //        })
        
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
        return self.customerList.count;
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("customerCell", forIndexPath: indexPath) as! CustomerCell;
        
//        cell.setCellValue(indexPath.row.description);
        cell.setCellValue(self.customerList[indexPath.row]);
        
        return cell
    }
    
    private var didSelectCustomer:Customer?
    private var didSelectBrand:Brand?;
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.didSelectBrand = nil;
        self.didSelectCustomer = nil;
        self.performSegueWithIdentifier("segueCustomerDetail", sender: tableView);
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let registerAction = UITableViewRowAction(style: .Default, title: "注册申请") { (action: UITableViewRowAction, indexPath:NSIndexPath) -> Void in
            self.performSegueWithIdentifier("segueCRMRegister", sender: self);
        }
        registerAction.backgroundColor = UIColor.grayColor();
        
        let moreAtion = UITableViewRowAction(style: .Normal, title: "更多",handler:self.moreActionClick);
        moreAtion.backgroundColor = UIColor.orangeColor();
        
        return [moreAtion,registerAction];
        
    }
    
    private func moreActionClick(action:UITableViewRowAction, indexPath:NSIndexPath){
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet);
        
        let uploadAttAction = UIAlertAction(title: "附件上传", style: UIAlertActionStyle.Default) { (action) -> Void in
            self.performSegueWithIdentifier("segueCRMAttUpload", sender: self);
        }
        let contractEditAction = UIAlertAction(title: "联系人编辑", style: UIAlertActionStyle.Default) { (action) -> Void in
            self.performSegueWithIdentifier("segueCRMContractEdit", sender: self);
        }
        let saleLogAtion = UIAlertAction(title: "日志", style: UIAlertActionStyle.Default) { (action) -> Void in
            
        }
        let deleteAction = UIAlertAction(title: "删除客户", style: UIAlertActionStyle.Destructive) { (action) -> Void in
            print("delete Customer");
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel) { (action) -> Void in
            print("cancel");
        }
        
        
        actionSheet.addAction(uploadAttAction);
        actionSheet.addAction(contractEditAction);
        actionSheet.addAction(saleLogAtion);
        actionSheet.addAction(deleteAction);
        actionSheet.addAction(cancelAction);
        
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
        else if segue.identifier == "segueCRMAttUpload"{
            let uploadCtrl = segue.destinationViewController as! CRMCustomerAttachmentUploadController;
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
    over
    ride func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
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
