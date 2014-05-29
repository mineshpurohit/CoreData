//
//  FBCDMasterViewController.h
//  FailedBankCD
//
//  Created by Harshal on 27/05/14.
//  Copyright (c) 2014 Triforce Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FBCDMasterViewController : UITableViewController

@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, strong) NSMutableArray *failedBankInfos;

- (IBAction) EditTableView;

@end
