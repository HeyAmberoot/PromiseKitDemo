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
        
        firstly {
            cookG()
        }.then {
            self.eat(data: $0)
        }.ensure {
            // something that should happen whatever the outcome
            }.catch {_ in
            
        }
        
 
    }
    //做饭
    func cookG() -> Guarantee<String> {
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

