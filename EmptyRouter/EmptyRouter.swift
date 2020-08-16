//
//  EmptyRouter.swift
//  MyKVO
//
//  Created by empty on 2020/8/8.
//  Copyright © 2020 empty. All rights reserved.
//
import UIKit

public let EmptyRouterManager = EmptyRouter.instance

public protocol EmptyRouterDelegate {

    var is_present:Bool { get }
    
    var animated:Bool { get }
    
    var hasDelegate:Bool { get }
    
    var modelStyle:UIModalPresentationStyle { get }
    
    var target_vc: UIViewController?{ get }
}

@objc
public class EmptyRouter:NSObject {
    @objc open class func shareInstance() -> EmptyRouter {
        return EmptyRouter.instance
    }
    
    class var instance:EmptyRouter {
        struct Static {
            static let ins = EmptyRouter()
        }
        return Static.ins
    }
    
    private var enmuRouter:EmptyRouterDelegate!
    private var arg:Dictionary<String,Any>?
    private var targetVC:UIViewController?
    
    @objc public func router(classType:UIViewController.Type,arg:Dictionary<String,Any>?) -> EmptyRouter{
        self.arg = arg
        self.targetVC = classType.init()
        let params:Dictionary<String,Any>? = arg
        self.enmuRouter = SetRouterInfo.init(params: params)
        return self
    }
    
    func selectedIndex(type:UIViewController.Type) {
        
    }
    
    public func router(_ emptyRouter: EmptyRouterDelegate,arg:Dictionary<String,Any>?) -> EmptyRouter{
        self.arg = arg
        self.enmuRouter = emptyRouter
        self.targetVC = emptyRouter.target_vc
        return self
    }
    
    @objc public func open(current: UIViewController,callBack:((_ argData:Dictionary<String,Any>)->Void)?) {
        if targetVC == nil {
            NSLog("控制器不存在")
            return
        }
        targetVC?.arg = arg
        if enmuRouter.hasDelegate {
            targetVC?.routerDelegate = current
        }
        
        if callBack != nil {
            targetVC?.routerCallBack = callBack
        }
        if enmuRouter.is_present {
            targetVC?.modalPresentationStyle = enmuRouter.modelStyle
            current.present(targetVC!, animated: enmuRouter.animated, completion: nil)
         }else {
            current.navigationController?.pushViewController(targetVC!, animated: enmuRouter.animated)
         }
     }
    
    @objc public func close(_ vc:UIViewController,callBackData:Dictionary<String,Any>? = nil) {
        if callBackData != nil {
            vc.routerCallBack?(callBackData!)
        }
        if enmuRouter.is_present {
            vc.dismiss(animated: enmuRouter.animated, completion: nil)
        }else {
            vc.navigationController?.popViewController(animated: enmuRouter.animated)
        }
        
        self.targetVC = nil
    }
    
}

@objc class SetRouterInfo : NSObject,EmptyRouterDelegate {
    var modelStyle: UIModalPresentationStyle{
        guard let p = self.params else { return .fullScreen}
        return p["modelStyle"] == nil ? .fullScreen : UIModalPresentationStyle.init(rawValue: p["modelStyle"] as! Int) ?? .fullScreen
    }
    
    var params:Dictionary<String,Any>?
    init(params:Dictionary<String,Any>?) {
        self.params = params
    }
    
    var is_present: Bool {
        guard let p = self.params else { return true}
        return p["is_present"] == nil ? false : p["is_present"] as! Bool
    }
    
    var animated: Bool {
        guard let p = self.params else { return true}
        return p["animated"] == nil ? false : p["animated"] as! Bool
    }
    
    var hasDelegate: Bool {
        guard let p = self.params else { return true}
        return p["delegate"] == nil ? false : p["delegate"] as! Bool
    }
    
    var target_vc: UIViewController?{
        return nil
    }
    
}
