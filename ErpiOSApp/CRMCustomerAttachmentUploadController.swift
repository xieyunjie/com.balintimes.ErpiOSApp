//
//  CRMCustomerAttachmentUploadController.swift
//  ErpiOSApp
//
//  Created by AlexXie on 15/12/24.
//  Copyright © 2015年 balintimes. All rights reserved.
//

import UIKit

class CRMCustomerAttachmentUploadController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var txtComment: UITextField!
    var isSelected = false;
    @IBOutlet weak var imgAttechment: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnSaveClick(sender: AnyObject) {
        
        if self.isSelected == false{
            let alert = DlgMsg.alert("系统提示", "请选择相片", handler: nil);
            self.presentViewController(alert, animated: true, completion: nil);
            return;
        }
        
        
        let block = BlockMsg.showLoading(self.view);
        
        var fields = Dictionary<String,String>();
        if let attComment = self.txtComment.text{
            fields["comment"] = attComment;
        }
        let files = ["image":self.imgAttechment.image!];
        
        
        RequestApi.upload(CrmReq.attUrl.rawValue, files: files, fields: fields, success: { (res:ResponseData<UploadResponse>) -> Void in
            BlockMsg.hideLoading(block); 
            
            if res.success == true{
                BlockMsg.showText(self.view, msg: "上传成功", afterDelay: 2.0);
                self.dismissViewControllerAnimated(true, completion: nil);
            }
            else{
                BlockMsg.showText(self.view, msg: "上传失败 -- \(res.msg)", afterDelay: 2.0);
            }
            
            
            }) { (err:NSError?) -> Void in
                
                BlockMsg.hideLoading(block);
                BlockMsg.showText(self.view, msg: "上传失败 -- \(err?.code)", afterDelay: 2.0);
                
        }
        
        
    }
    
    @IBAction func btnCancelClick(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    @IBAction func imgAttachmentClick(sender: AnyObject) {
        let imgPicker = UIImagePickerController();
        imgPicker.delegate = self;
        
        let actionSheet = UIAlertController(title: "", message: "", preferredStyle: .ActionSheet);
        let cameraAction = UIAlertAction(title: "拍照", style: .Default) { (action) -> Void in
            imgPicker.sourceType = .Camera
            self.presentViewController(imgPicker, animated: true, completion: nil);
        }
        
        let albumAction = UIAlertAction(title: "从相册读取", style: .Default) { (action) -> Void in
            imgPicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
            self.presentViewController(imgPicker, animated: true, completion: nil);
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: .Cancel, handler: nil);
        
        actionSheet.addAction(cameraAction);
        actionSheet.addAction(albumAction);
        actionSheet.addAction(cancelAction);
        
        self.presentViewController(actionSheet, animated: true) { () -> Void in
        }
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        self.isSelected = true;
        self.imgAttechment.image = info[UIImagePickerControllerOriginalImage] as? UIImage;
        
        picker.dismissViewControllerAnimated(true, completion: nil);
    }
    //
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
