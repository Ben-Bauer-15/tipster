//
//  ViewController.swift
//  tipster
//
//  Created by Ben Bauer on 10/31/18.
//  Copyright © 2018 Ben Bauer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var total = ""
    var tip_percentage = 10
    var tip_times_bill = Float()
    var bill_with_tip = Float()
    var group_size : Int = 1
    
    @IBOutlet weak var bill_before_tip: UILabel!
    @IBOutlet weak var group_size_label: UILabel!
    @IBOutlet var raw_tip: [UILabel]!
    @IBOutlet var tip_as_percentage: [UILabel]!
    @IBOutlet var tip_with_bill: [UILabel]!
    
    func convert_to_two_decimal_places(_ num : Float) -> String{
        let ans = String(format: "%.2f", num)
        return ans
    }
    
    
//    adjusts all the labels based on user input
    func display_tip_data(){
        var adjuster = tip_percentage
        for percentage in tip_as_percentage {
            percentage.text = String(adjuster) + "%"
            adjuster += 5
        }
        
        adjuster = tip_percentage
        for tip in raw_tip{
            if var bill = Float(total) {
                bill = (bill * (Float(adjuster) / 100.0)) / Float(group_size)
                tip.text = convert_to_two_decimal_places(bill)
            }
            adjuster += 5
        }
        
        adjuster = tip_percentage
        for tip_and_bill in tip_with_bill {
            if var bill = Float(total) {
                bill = ((bill * (Float(adjuster) / 100.0)) + bill) / Float(group_size)
                tip_and_bill.text = convert_to_two_decimal_places(bill)
            }
            adjuster += 5
        }
    }
    
    
//    listener for the tip slider
    @IBAction func tip_slider(_ sender: UISlider) {
        tip_percentage = Int(sender.value)
        display_tip_data()
    }
    
//    listener for the group size slider
    @IBAction func group_size_slider(_ sender: UISlider) {
        group_size = Int(sender.value)
        group_size_label.text = "Group Size: " + String(group_size)
        display_tip_data()
    }
    
    
    
    //    listener for all the buttons on the calculator
    @IBAction func calculator(_ sender: UIButton) {
        
        if sender.tag == -1 {
            total += "."
        }
        
        else if sender.tag == -2 {
            total = "0"
        }
        
        else if total == "0"{
            total = String(sender.tag)
        }
            
        else {
            total += String(sender.tag)
        }
        bill_before_tip.text = total
        
        display_tip_data()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bill_before_tip.text = "0"
    }
}

