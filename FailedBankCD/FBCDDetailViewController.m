//
//  FBCDDetailViewController.m
//  FailedBankCD
//
//  Created by Harshal on 28/05/14.
//  Copyright (c) 2014 Triforce Inc. All rights reserved.
//

#import "FBCDDetailViewController.h"

@interface FBCDDetailViewController ()

@end

@implementation FBCDDetailViewController

@synthesize objFailedBank, managedObjectContext;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(updateInformation)]];
    
    [self fillInformation];
    
}

- (void) fillInformation
{
    txtName.text = objFailedBank.name;
    txtCity.text = objFailedBank.city;
    txtState.text = objFailedBank.state;
    txtCDate.text = [self stringFromDate:objFailedBank.details.closeDate];
    txtUDate.text = [self stringFromDate:objFailedBank.details.updateDate];
    txtZip.text = [objFailedBank.details.zip stringValue];
}

- (NSString *) stringFromDate:(NSDate *) date
{
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd/MM/YYYY"];
    return [df stringFromDate:date];
}

- (NSDate *) dateFromString:(NSString *) string
{
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd/MM/YYYY"];
    return [df dateFromString:string];
}

- (IBAction) updateInformation
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if (self.objFailedBank) {
        
        self.objFailedBank.name = txtName.text;
        self.objFailedBank.city = txtCity.text;
        self.objFailedBank.state = txtState.text;
        self.objFailedBank.details.closeDate = [self dateFromString:txtCDate.text];
        self.objFailedBank.details.updateDate = [self dateFromString:txtUDate.text];
        self.objFailedBank.details.zip = [NSNumber numberWithInt:[txtZip.text intValue]];
        
    } else {
        
        FailedBankInfo *failedBankInfo = [NSEntityDescription
                                          insertNewObjectForEntityForName:@"FailedBankInfo"
                                          inManagedObjectContext:context];
        failedBankInfo.name = txtName.text;
        failedBankInfo.city = txtCity.text;
        failedBankInfo.state = txtState.text;
        
        FailedBankDetails *failedBankDetails = [NSEntityDescription
                                                insertNewObjectForEntityForName:@"FailedBankDetails"
                                                inManagedObjectContext:context];
        failedBankDetails.closeDate = [self dateFromString:txtCDate.text];
        failedBankDetails.updateDate = [self dateFromString:txtUDate.text];
        failedBankDetails.zip = [NSNumber numberWithInt:[txtZip.text intValue]];
        
        failedBankDetails.info = failedBankInfo;
        failedBankInfo.details = failedBankDetails;
        
    }
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
