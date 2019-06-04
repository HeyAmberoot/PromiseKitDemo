//
//  ViewController.swift
//  PromiseKitDemo
//
//  Created by xww on 2019/6/3.
//  Copyright © 2019 amberoot. All rights reserved.
//

import UIKit
import PromiseKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        firstly {
//            fetch()
//        }.then {
//            map($0)
//        }.then {
//            set($0)
//            return animate()
//        }.ensure {
//            // something that should happen whatever the outcome
//        }.catch {
//            handle(error: $0)
//        }
        //1.firstly() --
        //2.then() -- 要求输入一个promise值并返回一个promise。then 方法就是把原来的回调写法分离出来，在异步操作执行完后，用链式调用的方式执行回调函数。
        //3.ensure() --
        //4.done() -- 可以输入一个promise值并返回一个空的promise。因此我们会在整个链式调用的末尾使用done()方法做终结。
        //5.catch() -- 而 reject 方法就是把 Promise 的状态置为已失败（rejected），这时就能进到 catch 方法中，我们再次处理错误
        //7.map() -- 是根据先前 promise 的结果，然后返回一个新的对象或值类型
        //8.compactMap() -- 与 map() 类似，不过它是返回 Optional。比如我们返回 nil，则整个链会产生 PMKError.compactMap 错误。
        //9.finally -- 不管前面是 fulfill 还是 reject，最终都会进入到 finally方法里来。
        //10.get() -- 只有前面是完成状态（fulfilled）时才会调用
        //11.tap() -- 不管前面是完成（fulfilled）还是失败（rejected）都会调用，同时它得到的是 Result<T>：
        
        //then()、done()、catch()、finally()链式调用
        _ = cook(state: 0)
            .map({ (data) -> String in
                return data + ",配上老火靓汤"
            })
            .get({ (data) in
                print("get--\(data)")
            })
            .then(eat)
            .tap({ (result) in
                print("tap--\(result)")
            })
            .then(wash)
            .done { data in
                print(data)
            }.catch{ error in
                print(error.localizedDescription + "没法吃!")
            }.finally {
                print("出门上班")
        }
 
    }
    
    //做饭
    func cook(state: Int) -> Promise<String> {
        print("开始做饭。")
        let p = Promise<String> { resolver in
            //做一些异步操作(延迟1秒执行)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                if state == 0 {
                    print("做饭完毕！")
                    resolver.fulfill("鸡蛋炒饭")
                }else {
                    print("做饭失败！")
                    let error = NSError(domain:"PromiseKitTutorial", code: 0, userInfo: [NSLocalizedDescriptionKey: "烧焦的米饭"])
                    resolver.reject(error)
                }
            }
        }
        return p
    }
    
    //吃饭
    func eat(data:String) -> Promise<String> {
        print("开始吃饭：" + data)
        let p = Promise<String> { resolver in
            //做一些异步操作(延迟1秒执行)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                print("吃饭完毕！")
                resolver.fulfill("一个碗和一双筷子")
            }
        }
        return p
    }
    
    //洗碗
    func wash(data:String) -> Promise<String> {
        print("开始洗碗：" + data)
        let p = Promise<String> { resolver in
            //做一些异步操作(延迟1秒执行)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                print("洗碗完毕！")
                resolver.fulfill("干净的碗筷")
            }
        }
        return p
    }
    
    func savePhoto() {
        let image = UIImage(named: "demo")!
        PhotoAlbumUtil.saveImageInAlbum(image: image, albumName: "amberoot") { (result) in
            switch result{
            case .success:
                print("保存成功")
            case .denied:
                print("被拒绝")
            case .error:
                print("保存错误")
            }
        }
    }


}

