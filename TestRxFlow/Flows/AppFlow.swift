//
//  AppFlow.swift
//  TestRxFlow
//
//  Created by Farshad Sheykhi on 9/6/18.
//  Copyright © 2018 RxTest. All rights reserved.
//

import UIKit
import RxFlow

enum AppStep: Step {
    case normal
    case deepLink
}

class AppFlow: Flow {
    let storyboard = UIStoryboard(name: "Main", bundle: .main)

    var root: Presentable

    init(_ window: UIWindow) {
        root = window
    }

    func navigate(to step: Step) -> NextFlowItems {
        switch step {
        case AppStep.normal:
            let mainFlow = MainFlow()
            Flows.whenReady(flow1: mainFlow) { [unowned self] root in
                (self.root as! UIWindow).rootViewController = root
            }

            let stepperIdea = CompositeStepper(steppers: [OneStepper(withSingleStep: MainStep.start), DeepLinkStepper.shared])

            return .one(flowItem: NextFlowItem(nextPresentable: mainFlow, nextStepper: stepperIdea))
        case AppStep.deepLink:
            let viewController2 = storyboard.instantiateViewController(withIdentifier: "ViewController2") as! ViewController2
            (root as! UIWindow).rootViewController = viewController2
            return .one(flowItem: NextFlowItem(nextPresentable: viewController2, nextStepper: viewController2))
        default:
            return .none
        }
    }
}
