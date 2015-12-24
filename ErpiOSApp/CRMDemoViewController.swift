//
//  CRMDemoViewController.swift
//  merp
//
//  Created by yunjie Xie on 15/11/26.
//  Copyright © 2015年 balintimes. All rights reserved.
//

import UIKit
import MBProgressHUD
import JWT

class CRMDemoViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate {

    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtDate: UITextField!
    @IBOutlet weak var txtCityPicker: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtCity.inputView = UIView(frame: CGRectZero);
        txtDate.inputView = UIView(frame: CGRectZero);
        txtCityPicker.inputView  = UIView(frame: CGRectZero);

        // Do any additional setup after loading the view.
    }
    @IBAction func imgClick(sender: AnyObject) {
        print("imgclick");
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self);
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if textField == self.txtCityPicker{
            return false;
        }
        return true;
    }
    @IBAction func btnShowHUBClick(sender: AnyObject) {
//        BlockMsg.showDuring(self.view!) { () -> Void in
//            print("complete");
//        }
        
//        BlockMsg.showText(self.view!, msg: "提示啥？？", afterDelay: 2.0);
        BlockMsg.showText(self.view!, msg: "这个是提示", executAction: { () -> Void in
            sleep(2);
            print("execution");
            }) { () -> Void in
                print("complete");
        }
    }
    
    private var _cityPickerView:CityPickerViewController?;
    private var cityPickerView:CityPickerViewController{
        get {
            if self._cityPickerView == nil{
                self._cityPickerView = CityPickerViewController();
                let notificationListener = NSNotificationCenter.defaultCenter();
                notificationListener.addObserver(self, selector: Selector("listenerCityPickerViewShowEnd:"), name: DataPickerViewControllerNotification.PickerShowEndNotification.rawValue, object: self.cityPickerView);
                notificationListener.addObserver(self, selector: Selector("listenerCityPickerViewHideEnd:"), name: DataPickerViewControllerNotification.PickerHideEndNotification.rawValue, object: self.cityPickerView);
            }
            
            return self._cityPickerView!;
        }
    }
    @IBAction func txtCityPickerTouchDown(sender: AnyObject) {

        cityPickerView.show(self, sender, successAction:self.txtCityPickerDone,cancelAction:self.txtCityPickerCancel);
    }
    
    func listenerCityPickerViewShowEnd(notification: NSNotification){
        
        print(notification);
    }
    func listenerCityPickerViewHideEnd(notification: NSNotification){
        
        print(notification);
    }
    
    func txtCityPickerDone(picker:DataPickerViewController,province:Province,city:City){
        
        self.txtCityPicker.text = "\(province.name!) -> \(city.name!)";
    }
    func txtCityPickerCancel(picker:DataPickerViewController){
        print("cancel");
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func txtCityTouchDown(sender: AnyObject) {
        
        let cityPicker = CityPicker.create(controller: self, successAction: self.txtCityDone, cancelAction: self.txtCityCancel, origin: sender);
        
        cityPicker.showActionSheetPicker();
    }
    
    func txtCityDone(sender:BaseActionSheetPickerView,province:Province,city:City){
        txtCity.text = "\(province.name!) -> \(city.name!)";
    }
    func txtCityCancel(sender:BaseActionSheetPickerView){
        print("cancel");
    }
    
    var datePickerCtrl = DatePickerViewController();
    @IBAction func btnDatePickerClick(sender: AnyObject) {
        
        datePickerCtrl.show(self);
    }
    @IBAction func txtDateClick(sender: AnyObject) {
        datePickerCtrl.show(self, doneAction: self.txtDateDone,cancelAction: self.txtDateCancel);
    }
    
    func txtDateDone(sender:DatePickerViewController,date:NSDate){
        
        let format = NSDateFormatter();
//        format.dateFromString("yyyy-MM-dd");
        format.dateFormat = "yyyy-MM-dd";
        self.txtDate.text = format.stringFromDate(date);
    }
    func txtDateCancel(sender:DatePickerViewController){
        print("cancel");
    }
    
    
    @IBOutlet weak var uploadImage: UIImageView!
    @IBAction func btnTakePhotoClick(sender: AnyObject) {
        let imgPicker = UIImagePickerController();
        imgPicker.delegate = self;
        
        presentViewController(imgPicker, animated: true, completion: nil);
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        self.uploadImage.image = info[UIImagePickerControllerOriginalImage] as? UIImage;
        picker.dismissViewControllerAnimated(true, completion: nil);
    }
    
    @IBAction func btnUploadClick(sender: AnyObject) {
        
        MBProgressHUD.showHUDAddedTo(self.view, animated: true);
        
        let fields = ["customername":"coco"];
        
        RequestApi.upload("http://172.16.0.194:3000/crm/profile", files: ["image":self.uploadImage.image!], fields: fields, success: { (ret) -> Void in
            print(ret.success);
            
            MBProgressHUD.hideHUDForView(self.view, animated: true);
            }) { (err) -> Void in
                print(err);
                MBProgressHUD.hideHUDForView(self.view, animated: true);
        }
    }
    @IBAction func signClick(sender: AnyObject) {
        RequestApi.post(LoginReq.signinUrl.rawValue, nil) { (res:ResponseData<WebUser>) -> Void in
            
            
            UserDefaultsData.userToken(res.model?.token);
            
            print(UserDefaultsData.userToken()!);
            
        }
    }
    @IBAction func showtoken(sender: AnyObject) {
        
//        let urlRequest = NSMutableURLRequest(URL: NSURL(string: AppSetting.BaseUrl + LoginReq.verifyUrl.rawValue)!)
//        urlRequest.addValue("", forHTTPHeaderField: "");
//        
//        let session = NSURLSession.sharedSession();
//        
////        var response: AutoreleasingUnsafeMutablePointer<NSURLResponse>;
//        let data = session.data
        
        
//        UserDefaultsData.resetUserToken();
//        
//        RequestApi.post("crm/saveprovince", nil) { (res:ResponseData<Province>) -> Void in
//            if res.success == false{
//                BlockMsg.showText(self.view, msg: res.msg, afterDelay: 2.0);
//            }
//        }
//        do{
//            let payload = try JWT.decode(UserDefaultsData.userToken()!, algorithm: Algorithm.HS256(AppSetting.JWT.secret.rawValue));
//            print(payload)
//        }
//        catch{
//            print("Failed to decode JWT: \(error)")
//        }
    
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
