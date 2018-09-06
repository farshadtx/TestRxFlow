//
//  MainFlow.swift
//  TestRxFlow
//
//  Created by Farshad Sheykhi on 9/6/18.
//  Copyright © 2018 RxTest. All rights reserved.
//

import UIKit
import RxFlow

enum MainStep: Step {
    case start
    case navigate
    case subflow
    case end
}

class MainFlow: Flow {
    let storyboard = UIStoryboard(name: "Main", bundle: .main)

    var root: Presentable {
        return rootViewController
    }

    private lazy var rootViewController: UINavigationController = {
        return storyboard.instantiateViewController(withIdentifier: "Navigation1") as! UINavigationController
    }()

    func navigate(to step: Step) -> NextFlowItems {
        switch step {
        case MainStep.start:
            let viewController1 = storyboard.instantiateViewController(withIdentifier: "ViewController1") as! ViewController1
            rootViewController.setViewControllers([viewController1], animated: true)
            return .one(flowItem: NextFlowItem(nextPresentable: viewController1, nextStepper: viewController1))
        case MainStep.navigate:
            let viewController5 = storyboard.instantiateViewController(withIdentifier: "ViewController5") as! ViewController5
            rootViewController.pushViewController(viewController5, animated: true)
            return .one(flowItem: NextFlowItem(nextPresentable: viewController5, nextStepper: viewController5))
        case MainStep.subflow:
            let subFlow = SubFlow()
            Flows.whenReady(flow1: subFlow) { [unowned self] root in
                self.rootViewController.present(root, animated: true)
            }
            let stepperIdea = CompositeStepper(steppers: [OneStepper(withSingleStep: SubStep.start), DeepLinkStepper.shared])
            return .one(flowItem: NextFlowItem(nextPresentable: subFlow, nextStepper: stepperIdea))
        case AppStep.deepLink:
            return .end(withStepForParentFlow: AppStep.deepLink)
        default:
            return .none
        }
    }
}
