//
//  CRMCustomerRegisterFormController.swift
//  ErpiOSApp
//
//  Created by AlexXie on 15/12/25.
//  Copyright © 2015年 balintimes. All rights reserved.
//

import UIKit

@objc
protocol CRMCustomerRegisterFormControllerDelegate{
    func selectMediaType();
}


class CRMCustomerRegisterFormController: UITableViewController {
    
    @IBOutlet weak var lblCityMediaType: UILabel!
    
    @IBOutlet weak var mediaTypeCell: UITableViewCell!
    
    var delegate:CRMCustomerRegisterFormControllerDelegate?;
    
    func setCityMediaType(cityMediaType: [CityMediaType]){
        print(cityMediaType);
        var cellHeight = 40;
        var info = "";
        
        for city in cityMediaType {
            for media in city.mediatypelist{
                
                info += "\(city.cityname) -> \(media.medianame);\n";
                cellHeight += 40;
            }
        }
        self.lblCityMediaType.text = info;
        self.lblCityMediaType.numberOfLines = 0;
        self.mediaTypeCell.frame.size.height = CGFloat( cellHeight);
    }

    @IBAction func btnMediaTypeClick(sender: AnyObject) {
        if let d = self.delegate{
            d.selectMediaType();
        }
    }
    
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

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 3
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        if section == 2{
//            return 2;
//        }
//        return 3;
//    }
//
//    
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        
//        if indexPath.section  == 2{
//            let cell = tableView.dequeueReusableCellWithIdentifier("mediaTypeCell", forIndexPath: indexPath)
//            cell.textLabel?.text = "销售哈哈";
//            return cell;
//           
//        }
//        else{
//            return super.tableView(tableView, cellForRowAtIndexPath: indexPath);
//        }
//        
//    }


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
