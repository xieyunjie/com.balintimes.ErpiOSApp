//
//  TableViewFooterLoadMoreView.swift
//  ErpiOSApp
//
//  Created by AlexXie on 15/12/25.
//  Copyright © 2015年 balintimes. All rights reserved.
//

import UIKit

@objc
protocol TableViewFooterLoadMoreViewDelegate{
    optional func loadMoreBegin();
}

class TableViewFooterLoadMoreView: UIView {

    @IBOutlet weak var btnLoadMore: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var delegate:TableViewFooterLoadMoreViewDelegate!;
    
 
    @IBAction func btnLoadMoreClick(sender: AnyObject) {
        btnLoadMore.setTitle("正在加载....", forState: .Disabled);
        btnLoadMore.enabled = false;
        self.activityIndicator.startAnimating();
        
        delegate.loadMoreBegin!();
    }
    
    func stopLoading(){
        btnLoadMore.setTitle("加载更多", forState: .Normal);
        btnLoadMore.enabled = true;
        self.activityIndicator.stopAnimating();
    }

    
    static func createFooter(frame: CGRect,delegate:TableViewFooterLoadMoreViewDelegate) -> TableViewFooterLoadMoreView{
        
        let view = NSBundle.mainBundle().loadNibNamed("TableViewFooterLoadMoreView", owner: nil, options: nil).first as! TableViewFooterLoadMoreView;
        view.frame = frame;
        view.stopLoading();
        view.delegate = delegate;
        
        return view;
        
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
