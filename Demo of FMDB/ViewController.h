//
//  ViewController.h
//  Demo of FMDB
//
//  Created by Sagar Shirbhate on 30/05/14.
//  Copyright (c) 2014 com.deviseapps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMDatabase.h"

@interface ViewController : UIViewController
{
       FMDatabase * database;
       NSMutableArray *fields;
}
@end
