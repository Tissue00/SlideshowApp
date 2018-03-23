//
//  ViewController.swift
//  SlideshowApp
//
//  Created by 中島隆斗 on 2018/03/19.
//  Copyright © 2018年 ryuto.nakashima. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var slideshow: UIImageView!
    
    @IBOutlet weak var disanext: UIButton!
    @IBOutlet weak var disaback: UIButton!
    @IBOutlet weak var buttonname: UIButton!
    
    var slide: Timer!
    
    var nowimg = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setImage()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let secondViewController = segue.destination  as! SecondViewController
        secondViewController.image = slideshow.image
        
        if slide != nil{
            slide.invalidate()
            slide = nil
            buttonname.setTitle("再生", for: UIControlState.normal)
            disanext.isEnabled = true
            disaback.isEnabled = true
            
        }
    }
    
    @IBAction func startstop(_ sender: Any) {
        if slide == nil{
            slide = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(updateSlide), userInfo: nil,repeats: true)
            buttonname.setTitle("停止", for: UIControlState.normal)
            disanext.isEnabled = false
            disaback.isEnabled = false
        }else {
            slide.invalidate()
            slide = nil
            buttonname.setTitle("再生", for: UIControlState.normal)
            disanext.isEnabled = true
            disaback.isEnabled = true
        }
    }
    
    func setImage() {
        var img = [#imageLiteral(resourceName: "image1"), #imageLiteral(resourceName: "image2"), #imageLiteral(resourceName: "image3")]
        slideshow.image = img[nowimg]
    }

    func process() {
        if nowimg < 2 {
            nowimg += 1
        }else{
            nowimg = 0
        }
    }

    @IBAction func backimg(_ sender: Any) {
        if nowimg > 0  {
            nowimg -= 1
        }else{
            nowimg = 2
        }
        setImage()
    }

    @IBAction func nextimg(_ sender: Any) {
        process()
        setImage()
    }

    @objc func updateSlide(slide: Timer) {
        process()
        setImage()
    }
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
    }
}
