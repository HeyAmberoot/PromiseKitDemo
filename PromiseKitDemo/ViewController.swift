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
//
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
        _ = cook()
            .then(eat)
            .then(wash)
            .done { data in
                print(data)
        }
        
    }
    //做饭
    func cook() -> Promise<String> {
        print("开始做饭。")
        let p = Promise<String> { resolver in
            //做一些异步操作(延迟1秒执行)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                print("做饭完毕！")
                resolver.fulfill("鸡蛋炒饭")
            }
        }
        return p
    }
    
    //吃饭
    func eat(data:String) -> Promise<String> {
        print("开始吃饭：" + data)
        let p = Promise<String> { resolver in
            //做一些异步操作(延迟1秒执行)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                print("吃饭完毕！")
                resolver.fulfill("一块碗和一双筷子")
            }
        }
        return p
    }
    
    //洗碗
    func wash(data:String) -> Promise<String> {
        print("开始洗碗：" + data)
        let p = Promise<String> { resolver in
            //做一些异步操作(延迟1秒执行)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
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

