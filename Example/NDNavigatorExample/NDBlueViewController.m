//
//  NDBlueViewController.m
//  NDNavigatorExample
//
//  Created by Neil Davis on 20/07/2014.
//  Copyright (c) 2014 Neil Davis. All rights reserved.
//

#import "NDBlueViewController.h"

@interface NDBlueViewController ()

@property (weak, nonatomic) IBOutlet UILabel *msgIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *msgTextLabel;

@property (nonatomic, assign) NSUInteger msgId;
@property (nonatomic, strong) NSString *msgText;

@end

@implementation NDBlueViewController

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
    [self setLabelTexts];
    if (self.navigationController.presentingViewController)
    {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismiss:)];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setMessageWithId:(NSUInteger)msgId text:(NSString*)msgText;
{
    self.msgText = msgText;
    self.msgId = msgId;
    [self setLabelTexts];
}

- (void) setLabelTexts
{
    if (self.isViewLoaded)
    {
        _msgIdLabel.text = [NSString stringWithFormat:@"ID: %lu", (unsigned long)self.msgId];
        _msgTextLabel.text = self.msgText;
    }
}

- (void)dismiss:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
