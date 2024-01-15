//
//  ViewController.swift
//  TimerApp
//
//  Created by 이가을 on 1/15/24.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    ////////////////////////////////////////////////////////////////////////////////// member
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    var timer: Timer?
    var sliderValue: Int = 0
    var timeSet: Int = 0
    let systemSoundID: SystemSoundID = 1016 // for playing system sound
    
    ////////////////////////////////////////////////////////////////////////////////// init
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    func initUI(){
        mainLabel.text = "Select Time to Set"
        slider.value = 0.5
    }

    
    ////////////////////////////////////////////////////////////////////////////////// events
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        sliderValue = Int(sender.value * 60)
        mainLabel.text = "\(sliderValue)초"
    }
        
    @IBAction func resetBtnTapped(_ sender: UIButton) {
        initUI()
        timer?.invalidate()
    }
    
    @IBAction func startBtnTapped(_ sender: UIButton) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCallback), userInfo: nil, repeats: true) // timer가 왜 이렇게 동작하는지? -> 정확히는, scheduledTimer의 각 파라메터들이 무슨 역할인지
        timeSet = sliderValue
    }
    
    @objc func timerCallback(){
        if timeSet > 0{
            timeSet -= 1
            mainLabel.text = "\(timeSet)초"
            slider.value = Float(timeSet) / Float(60)
        } else {
            mainLabel.text = "Time's Up"
            AudioServicesPlaySystemSound(systemSoundID)
            timer?.invalidate()
        }
    }
}

