//
//  SimpleBindingsViewController.swift
//  GoReactive
//
//  Created by Gal Orlanczyk on 12/24/2018.
//  Copyright (c) 2018 Gal Orlanczyk. All rights reserved.
//

import UIKit
import GoReactive

struct SimpleBindingsViewModel {
    let bindableLabelProperty = Property<String?>(nil)
    let bindableTextFieldProperty = Property<String?>(nil)
}

class SimpleBindingsViewController: UITableViewController {

    let viewModel = SimpleBindingsViewModel()
    let cancelableGroup = CancelableGroup()
    
    @IBOutlet weak var bindableLabel: UILabel!
    @IBOutlet weak var changeTextButton: UIButton!
    
    @IBOutlet weak var bindableTextField: UITextField!
    @IBOutlet weak var bindableTextFieldLabel: UILabel!
    @IBOutlet weak var clearTextFieldButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = 60
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.setupBindings()
    }

    func setupBindings() {
        self.viewModel.bindableLabelProperty
            .bind(to: self.bindableLabel.reactiveComponent.text)
            .add(to: self.cancelableGroup)
        
        self.changeTextButton.reactiveComponent.touchUpInside.subscribe(onNext: {
            self.viewModel.bindableLabelProperty.value = "\(Int.random(in: 0 ... 10000000))"
        }).add(to: self.cancelableGroup)
        
        // can be written also from the second way because this is bidirectional...
        self.bindableTextField.reactiveComponent.text
            .bidirectionalBind(to: self.viewModel.bindableTextFieldProperty)
            .add(to: self.cancelableGroup)
        
        self.viewModel.bindableTextFieldProperty
            .bind(to: self.bindableTextFieldLabel.reactiveComponent.text)
            .add(to: self.cancelableGroup)
        
        self.clearTextFieldButton.reactiveComponent.touchUpInside.subscribe(onNext: {
            self.viewModel.bindableTextFieldProperty.value = ""
        }).add(to: self.cancelableGroup)
    }
    
    deinit {
        self.cancelableGroup.cancel()
    }
}

