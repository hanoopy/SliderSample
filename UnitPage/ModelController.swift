//
//  ModelController.swift
//  UnitPage
//
//  Created by yukichi on 2014/11/11.
//  Copyright (c) 2014年 hanoopy. All rights reserved.
//

import UIKit

/*
 A controller object that manages a simple model -- a collection of month names.
 
 The controller serves as the data source for the page view controller; it therefore implements pageViewController:viewControllerBeforeViewController: and pageViewController:viewControllerAfterViewController:.
 It also implements a custom method, viewControllerAtIndex: which is useful in the implementation of the data source methods, and in the initial configuration of the application.
 
 There is no need to actually create view controllers for each page in advance -- indeed doing so incurs unnecessary overhead. Given the data model, these methods create, configure, and return a new view controller on demand.
 */


class ModelController: NSObject, UIPageViewControllerDataSource {

    var pageData = NSArray()
    var pageAnimalData:Dictionary<Int, Dictionary<String, String>>!


    override init() {
        super.init()
        // Create the data model.
        let dateFormatter = NSDateFormatter()
//        pageData = dateFormatter.monthSymbols
//        pageData = ["小太郎", "諭吉", "さくら"]
//        
        //データ取得
        var animals = Dictionary<Int, Dictionary<String, String>>()
        animals[1] = ["id": "1", "name": "DOG"]
        animals[2] = ["id": "2", "name": "CAT"]
        animals[3] = ["id": "3", "name": "RABBIT"]
        
        self.pageAnimalData = animals
        
    }

    func viewControllerAtIndex(index: Int, storyboard: UIStoryboard) -> DataViewController? {
        // Return the data view controller for the given index.
        if (self.pageAnimalData.count == 0) || (index >= self.pageAnimalData.count + 1) {
            return nil
        }

        // Create a new view controller and pass suitable data.
        let dataViewController = storyboard.instantiateViewControllerWithIdentifier("DataViewController") as DataViewController
        dataViewController.dataObject
            //= self.pageData[index]
            = self.pageAnimalData[index]
        return dataViewController
    }

    func indexOfViewController(viewController: DataViewController) -> Int {
        // Return the index of the given data view controller.
        // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
        
        if let dataObject: AnyObject = viewController.dataObject {
            var dicObject = dataObject as Dictionary<String, String>
            return dicObject["id"]!.toInt()!
        } else {
            return NSNotFound
        }
    }

    // MARK: - Page View Controller Data Source

    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as DataViewController)
        if (index == 1) || (index == NSNotFound) {
            return nil
        }
        
        index--
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }

    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as DataViewController)
        if index == NSNotFound {
            return nil
        }
        
        index++
        if index == self.pageAnimalData.count + 1 {
            return nil
        }
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }

}

