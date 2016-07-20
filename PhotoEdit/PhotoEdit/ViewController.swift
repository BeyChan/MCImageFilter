//
//  ViewController.swift
//  PhotoEdit
//
//  Created by Melody Chan on 16/7/20.
//  Copyright © 2016年 canlife. All rights reserved.
//

import UIKit
import CoreImage
class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    
    lazy var context: CIContext = {
        return CIContext(options: nil)
    }()
    var filter: CIFilter!

    
    private lazy var originalImage:UIImage = {
        return UIImage(named:"005.jpg")!
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        showFiltersInConsole()
    }


    @IBAction func showOriginalImage(sender: UIButton) {
        self.imageView.image = originalImage
    }

    @IBAction func autoAdjust(sender: UIButton) {
        let inputImage = CIImage(image: originalImage)
        let option:[String:AnyObject] = [CIDetectorImageOrientation:1,CIDetectorSmile:1,CIDetectorEyeBlink:1]
        let filters = inputImage?.autoAdjustmentFiltersWithOptions(option)
        var oupputImage:CIImage = CIImage.emptyImage()
        for filter: CIFilter in filters! {
            filter.setValue(inputImage, forKey: kCIInputImageKey)
            oupputImage = filter.outputImage!
        }
    
        let context = CIContext(options: nil)
        //进一步优化
        let ref = context.createCGImage(oupputImage, fromRect: oupputImage.extent)
        let finnalImage = UIImage(CGImage: ref)
        //回到主线程刷新UI
        dispatch_async(dispatch_get_main_queue()) { 
            self.imageView.image = finnalImage
        }
        
    }
    
    func showFiltersInConsole() {
        let filterNames = CIFilter.filterNamesInCategory(kCICategoryColorEffect)
        print(filterNames.count)
        print(filterNames)
        for filterName in filterNames {
            let filter = CIFilter(name: filterName as String)
            let attributes = filter!.attributes
            print(attributes)
        }
    }
    
    // MARK: - 怀旧
    @IBAction func photoEffectInstant() {
        filter = CIFilter(name: "CIPhotoEffectInstant")
        outputImage()
    }
    // MARK: - 黑白
    @IBAction func photoEffectNoir() {
        filter = CIFilter(name: "CIPhotoEffectNoir")
        outputImage()
    }
    // MARK: - 色调
    @IBAction func photoEffectTonal() {
        filter = CIFilter(name: "CIPhotoEffectTonal")
        outputImage()
    }
    // MARK: - 岁月
    @IBAction func photoEffectTransfer() {
        filter = CIFilter(name: "CIPhotoEffectTransfer")
        outputImage()
    }
    // MARK: - 单色
    @IBAction func photoEffectMono() {
        filter = CIFilter(name: "CIPhotoEffectMono")
        outputImage()
    }
    // MARK: - 褪色
    @IBAction func photoEffectFade() {
        filter = CIFilter(name: "CIPhotoEffectFade")
        outputImage()
    }
    // MARK: - 冲印
    @IBAction func photoEffectProcess() {
        filter = CIFilter(name: "CIPhotoEffectProcess")
        outputImage()
    }
    // MARK: - 铬黄
    @IBAction func photoEffectChrome() {
        filter = CIFilter(name: "CIPhotoEffectChrome")
        outputImage()
    }
    @IBAction func photoEffectMaskToAlpha() {
        filter = CIFilter(name: "CIMaskToAlpha")
        outputImage()
    }
    @IBAction func photoEffectColorMonochrome() {
        filter = CIFilter(name: "CIColorMonochrome")
        outputImage()
    }

    func outputImage() {
        print(filter)
        let inputImage = CIImage(image: originalImage)
        filter.setValue(inputImage, forKey: kCIInputImageKey)
        let outputImage =  filter.outputImage!
        let cgImage = context.createCGImage(outputImage, fromRect: outputImage.extent)
        self.imageView.image = UIImage(CGImage: cgImage)
    }

}

