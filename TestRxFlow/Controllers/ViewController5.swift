//
//  ViewController.swift
//  TestRxFlow
//
//  Created by Farshad Sheykhi on 9/6/18.
//  Copyright © 2018 RxTest. All rights reserved.
//

import UIKit
import RxFlow

class ViewController5: UIViewController, Stepper {

    @IBOutlet weak var button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        button.rx.tap
            .map { _ in MainStep.subflow }
            .bind(to: step)
            .disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

