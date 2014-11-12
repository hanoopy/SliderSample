//
//  DataViewController.swift
//  UnitPage
//
//  Created by yukichi on 2014/11/11.
//  Copyright (c) 2014年 hanoopy. All rights reserved.
//

import UIKit

class DataViewController: UIViewController {

    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var petImage: UIImageView!
    @IBOutlet var animalName: UILabel!
    var dataObject: AnyObject?


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        if let obj: AnyObject = dataObject {
            var ar = obj as Dictionary<String, String>
            
            self.dataLabel!.text = obj.description
            self.animalName!.text = ar["name"]
            self.petImage.image = UIImage(named:ar["id"]! + ".jpg")
        } else {
            self.dataLabel!.text = ""
        }
    }


}

