//
//  CRMRegisterMediaTypeController.swift
//  ErpiOSApp
//
//  Created by AlexXie on 15/12/25.
//  Copyright © 2015年 balintimes. All rights reserved.
//

import UIKit

@objc
protocol CRMRegisterMediaTypeControllerDelegate{
    func CityMediaTypeDone(cityMediaType:[CityMediaType]);
}

class CRMRegisterMediaTypeController: UITableViewController {
    
    var delegate:CRMRegisterMediaTypeControllerDelegate?;
    
    var cityMediaType = Array<CityMediaType>();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        RequestApi.get(CrmReq.mediaTypeUrl.rawValue, nil) { (res:ResponseData<CityMediaType>) -> Void in
            
            if res.success == true{
                self.cityMediaType = res.list!;
                print(self.cityMediaType[0].mediatypelist);
                self.tableView.reloadData() ;
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.cityMediaType.count;
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.cityMediaType[section].mediatypelist.count;
    }
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.cityMediaType[section].cityname;
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cityMediaTypeCell", forIndexPath: indexPath);
        let city = self.cityMediaType[indexPath.section];
        let mediaType = city.mediatypelist[indexPath.row];
        cell.textLabel?.text = mediaType.medianame;
        
        if mediaType.isspecial == true {
            cell.textLabel?.textColor = UIColor.blueColor();
        }
        
        if mediaType.isCheck == true{
            cell.accessoryType = .Checkmark;
        }
        else{
            cell.accessoryType = .None;
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)!;
        
        if cell.accessoryType == .Checkmark{
            cell.accessoryType = .None;
            cityMediaType[indexPath.section].mediatypelist[indexPath.row].isCheck = false;
        }
        else{
            cell.accessoryType = .Checkmark;
            cityMediaType[indexPath.section].mediatypelist[indexPath.row].isCheck = true;
        }
    }
    
    @IBAction func btnDoneClick(sender: AnyObject) {
        var result:[CityMediaType] = [];
        
        for city in cityMediaType {
            
            var selectedMediaTypes:[MediaType] = [];
            
            for media in city.mediatypelist{
                if media.isCheck == true{
                    selectedMediaTypes.append(media);
                }
            }
            
            if selectedMediaTypes.count > 0{
                let c = CityMediaType();
                c.uid = city.uid;
                c.cityname = city.cityname;
                c.comment = city.comment;
                c.mediatypelist = selectedMediaTypes;
                result.append(c);
            }
        }
        
        if result.count <= 0 {
            BlockMsg.showText(self.view, msg: "请选择媒体类型", afterDelay: 1.5);
        }
        else if let d = self.delegate{
            d.CityMediaTypeDone(result);
        }
    }
    
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
