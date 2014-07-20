//
//  NDRootViewController.m
//  NDNavigatorExample
//
//  Created by Neil Davis on 20/07/2014.
//  Copyright (c) 2014 Neil Davis. All rights reserved.
//

#import "NDRootViewController.h"
#import "UIViewController+NDNavigator.h"
#import "UINavigationController+NDNavigator.h"

@interface NDRootViewController () <UIActionSheetDelegate>

@property (nonatomic, strong) NSURL *nextURL;

@end

@implementation NDRootViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)didPressButton:(UIButton *)sender {
    NSString *urlString = sender.titleLabel.text;
    NSURL *url = [NSURL URLWithString:urlString];
    if (url)
    {
        self.nextURL = url;
        // Present action sheet allowing choice of push/present
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:urlString delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Push Navigation", @"Present Modal", @"Present in Nav", nil];
        [sheet showInView:self.view];
    }
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != actionSheet.cancelButtonIndex)
    {
        if (0 == buttonIndex)
        {
            // Push navigation
            [self.navigationController pushViewControllerWithURL:self.nextURL animated:YES];
        }
        else if (1 == buttonIndex)
        {
            // Present modally
            [self presentViewControllerWithURL:self.nextURL animated:YES config:^(UIViewController *vc) {
                
            } completion:^{
                // Auto dismiss
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self dismissViewControllerAnimated:YES completion:nil];
                });
            }];
        }
        else if (2 == buttonIndex)
        {
            // Present in nav controller
            UINavigationController *navController = [[UINavigationController alloc] initWithRootControllerURL:self.nextURL navigationMap:self.navigationMap];
            [self presentViewController:navController animated:YES completion:nil];
        }
    }
}

@end
