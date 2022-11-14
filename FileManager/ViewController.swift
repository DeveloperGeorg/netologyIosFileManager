//
//  ViewController.swift
//  FileManager
//
//  Created by Георгий Бондаренко on 14.11.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let documentDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        print(documentDir)
        let content = try? FileManager.default.contentsOfDirectory(atPath: documentDir.path)
        print(content)
    }


}

