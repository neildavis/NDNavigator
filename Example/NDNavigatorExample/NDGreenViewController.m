//
//  NDGreenViewController.m
//  NDNavigatorExample
//
//  Created by Neil Davis on 20/07/2014.
//  Copyright (c) 2014 Neil Davis. All rights reserved.
//

#import "NDGreenViewController.h"
#import "UIViewController+NDNavigator.h"

@interface NDGreenViewController ()

@property (nonatomic, assign) NSUInteger msgId;
@property (nonatomic, strong) NSString *msgText;
@property (nonatomic, weak) UIAlertView *alert;

@end

@implementation NDGreenViewController

- (void) dealloc
{
    [self.alert dismissWithClickedButtonIndex:self.alert.cancelButtonIndex animated:NO];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _msgId = 0;
        _msgText = @"<No Message>";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor greenColor];
    if (self.navigationController.presentingViewController)
    {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismiss:)];
    }
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self showAlert];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) showAlert
{
    if (self.isViewLoaded)
    {
        [self.alert dismissWithClickedButtonIndex:self.alert.cancelButtonIndex animated:NO];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"ID: %lu", (unsigned long)self.msgId] message:self.msgText delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        self.alert = alert;
    }
}

- (void) dismiss:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIViewController+NDNavigator

- (void) willNavigateWithPathParamaters:(NSDictionary*)pathParams queryParameters:(NSDictionary*)queryParams;
{
    [super willNavigateWithPathParamaters:pathParams queryParameters:queryParams];
    NSArray *newMsgId = queryParams[@"msgId"];
    NSArray *newMsgText = queryParams[@"msgText"];
    if (newMsgId && newMsgText)
    {
        // Query params are mapped Key:(NSString*) -> Value:(NSArray*) since query params are not necessarilly unique
        self.msgId = [[newMsgId firstObject] integerValue];
        self.msgText = [newMsgText firstObject];
        [self showAlert];
    }
}


@end
