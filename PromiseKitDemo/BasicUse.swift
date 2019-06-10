//
//  BasicUse.swift
//  PromiseKitDemo
//
//  Created by xww on 2019/6/5.
//  Copyright © 2019 amberoot. All rights reserved.
//

import Foundation
import PromiseKit

class BasicUse {
    /*
     Promise: 灵活的异步操作，可成功可失败
     Guarantee: 灵活的异步操作，只可成功
     */
    init() {
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
        //12.when() -- 提供了并行执行异步操作的能力，并且只有在所有异步操作执行完后才执行回调
        //13.race() -- race的用法与when一样，只不过when是等所有异步操作都执行完毕后才执行then回调。而race的话只要有一个异步操作执行完毕，就立刻执行then回调。
        //14.after() --
        after(seconds: 6).done {
            print("欢迎")
        }
        
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
        
        //when:两个异步操作是并行执行的，等到它们都执行完后才会进到done 里面。同时when会把所有异步操作的结果传给done。
        _ = when(fulfilled: cutUp(), boil())
            .done{ result1, result2 in
                print("when结果：\(result1)、\(result2)")
        }
        
        //race: 用法与when一样，只不过when是等所有异步操作都执行完毕后才执行then回调。而race的话只要有一个异步操作执行完毕，就立刻执行then回调。
        _ = race(cutUp(), boil())
            .done{ data in
                print("race结果：\(data)")
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
    
    //做饭
    func cookG(state: Int) -> Guarantee<String> {
        print("开始做饭。")
        let g = Guarantee<String> { seal in
            //做一些异步操作(延迟1秒执行)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                print("做饭完毕！")
                seal("鸡蛋炒饭")
            }
        }
        return g
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
    
    //切菜
    func cutUp() -> Promise<String> {
        print("开始切菜。")
        let p = Promise<String> { resolver in
            //做一些异步操作(延迟2秒执行)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                print("切菜完毕！")
                resolver.fulfill("切好的菜")
            }
        }
        return p
    }
    
    //烧水
    func boil() -> Promise<String> {
        print("开始烧水。")
        let p = Promise<String> { resolver in
            //做一些异步操作(延迟1秒执行)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                print("烧水完毕！")
                resolver.fulfill("烧好的水")
            }
        }
        return p
    }
    
    
}

