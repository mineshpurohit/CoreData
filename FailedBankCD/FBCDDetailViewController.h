//
//  FBCDDetailViewController.h
//  FailedBankCD
//
//  Created by Harshal on 28/05/14.
//  Copyright (c) 2014 Triforce Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FailedBankInfo.h"
#import "FailedBankDetails.h"

@interface FBCDDetailViewController : UIViewController {

    IBOutlet UITextField * txtName, * txtCity, * txtState, * txtCDate, *txtUDate, * txtZip;

}

@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, strong) FailedBankInfo *objFailedBank;

- (IBAction) updateInformation;

@end
