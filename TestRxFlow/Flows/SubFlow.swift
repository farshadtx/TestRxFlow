//
//  SubFlow.swift
//  TestRxFlow
//
//  Created by Farshad Sheykhi on 9/6/18.
//  Copyright © 2018 RxTest. All rights reserved.
//

import UIKit
import RxFlow

enum SubStep: Step {
    case start
    case navigate
    case end
}

class SubFlow: Flow {
    let storyboard = UIStoryboard(name: "Main", bundle: .main)

    var root: Presentable {
        return rootViewController
    }

    private lazy var rootViewController: UINavigationController = {
        return storyboard.instantiateViewController(withIdentifier: "Navigation2") as! UINavigationController
    }()


    func navigate(to step: Step) -> NextFlowItems {
        switch step {
        case SubStep.start:
            let viewController3 = storyboard.instantiateViewController(withIdentifier: "ViewController3") as! ViewController3
            rootViewController.setViewControllers([viewController3], animated: true)
            return .one(flowItem: NextFlowItem(nextPresentable: viewController3, nextStepper: viewController3))
        case SubStep.navigate:
            let viewController4 = storyboard.instantiateViewController(withIdentifier: "ViewController4") as! ViewController4
            rootViewController.pushViewController(viewController4, animated: true)
            return .one(flowItem: NextFlowItem(nextPresentable: viewController4, nextStepper: viewController4))
        case AppStep.deepLink:
            return .end(withStepForParentFlow: AppStep.deepLink)
        default:
            return .none
        }
    }
}
