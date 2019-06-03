//
//  ViewController.swift
//  PromiseKitDemo
//
//  Created by xww on 2019/6/3.
//  Copyright © 2019 amberoot. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
       
        
        
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

