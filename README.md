### Swift 编写的路由 ###
**Swift使用方式新建一个枚举并实现代理EmptyRouterDelegate**
```
public enum MyRouter : String {
  case HomePage = "HomePage"
}

extension MyRouter : EmptyRouterDelegate {
    public var modelStyle: UIModalPresentationStyle {
        switch self {
        case .HomePage:
            return .overFullScreen
        default:
            return .custom
        }
    }
    
    public var hasDelegate: Bool {
        return true
    }
    
    public var target_vc: UIViewController? {
        switch self {
        case .HomePage:
            return HomePage()
    }
    
 
    
    public var animated: Bool {
        switch self {
        case .HomePage:
            return false
        default:
            return true
        }
    }
    
    public var is_present: Bool{
        switch self {
        case .HomePage:
            return false
        default:
            return true
        }
    }
}

```
跳转的地方使用
```
let arg = ["title":"Home Page","content":"this is Home Page!"]
EmptyRouterManager.router(MyRouter(rawValue: "HomePage") ?? MyRouter.NonePage, arg: arg).open(current: self,callBack: {
    (argData:Dictionary<String,Any>) in
    print("callback \(argData)")
}) 或

EmptyRouterManager.router(MyRouter.HomePage, arg: arg).open(current: self,callBack: {
    (argData:Dictionary<String,Any>) in
    print("callback \(argData)")
})

```
返回不能用系统的返回，不能用不能用，使用下面返回需要传值回调传入相应值即可
```
let callbackData = ["content":"secode callback data 哈哈"]
EmptyRouterManager.close(self,callBackData: callbackData)
```
**OC使用**

不需要回掉callback可传nil，跳转 arg 下面四个字修改相应的跳转方式动画是否有可代理回调，modelStyle is_present true时有用 需要传其他值键入key value即可
```
NSDictionary *arg = @{@"animated":[NSNumber numberWithBool:true],@"delegate":[NSNumber numberWithBool:true],@"is_present":[NSNumber numberWithBool:true],@"modelStyle":[NSNumber numberWithInt:UIModalPresentationOverFullScreen]};

[[[EmptyRouter shareInstance] routerWithClassType:[HomePageVC class] arg:arg] openWithCurrent:self callBack:^(NSDictionary<NSString *,id> * argData) {

}];

返回

[[EmptyRouter shareInstance] close:self callBackData:nil];

``` 
