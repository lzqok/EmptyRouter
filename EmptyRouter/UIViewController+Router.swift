//
//  UIViewController+Router.swift
//  MyKVO
//
//  Created by empty on 2020/8/8.
//  Copyright © 2020 empty. All rights reserved.
//
import UIKit

@objc public protocol RouterDelegate {
    func callbackData(_ arg:Dictionary<String,Any>?)
}

extension UIViewController:RouterDelegate {
    public typealias EmptyCallBack = (_ argData:Dictionary<String,Any>)->Void
    struct consKey {
        static var argKey = "argKey"
        static var delegateKey = "delegateKey"
        static var callBackKey = "callbackKey"
    }
    
    @objc public var arg:Dictionary<String,Any>? {
        set{
            objc_setAssociatedObject(self, &consKey.argKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &consKey.argKey) as? Dictionary<String, Any>
        }
    }
    
    @objc public weak var routerDelegate:RouterDelegate? {
        set{
            objc_setAssociatedObject(self, &consKey.delegateKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        }
        get{
            return objc_getAssociatedObject(self, &consKey.delegateKey) as? RouterDelegate
        }
    }
    
    @objc public var routerCallBack:EmptyCallBack? {
        set{
            objc_setAssociatedObject(self, &consKey.callBackKey, newValue, .OBJC_ASSOCIATION_COPY)
        }
        get{
            return objc_getAssociatedObject(self, &consKey.callBackKey) as? UIViewController.EmptyCallBack
        }
    }
    open func callbackData(_ arg: Dictionary<String, Any>?) {
        print(arg)
    }
    
}
