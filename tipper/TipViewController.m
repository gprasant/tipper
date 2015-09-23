//
//  TipViewController.m
//  tipper
//
//  Created by Prasanth Guruprasad on 9/20/15.
//  Copyright (c) 2015 Prasanth Guruprasad. All rights reserved.
//

#import "TipViewController.h"
#import "SettingsViewController.h"

@interface TipViewController ()
@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;

- (IBAction)onTap:(id)sender;
- (void) updateValues:(BOOL) animated;
- (void) onSettingsButton;
- (void) present: (id) billAmount withIndex:(NSInteger) tipIndex;

@end

@implementation TipViewController

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
   
    if(self) {
        // wire up events for application active and inactive
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                selector:@selector(onApplicationDidBecomeActive)
                                                name:UIApplicationDidBecomeActiveNotification
                                                   object: nil];
        [[NSNotificationCenter defaultCenter] addObserver: self
                                                 selector: @selector(onApplicationWillResignActive)
                                                     name: UIApplicationWillResignActiveNotification
                                                   object: nil];
    }
    return self;
}

-(void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationDidBecomeActiveNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationWillResignActiveNotification
                                                  object:nil];
}

-(void) onApplicationDidBecomeActive {
    NSUserDefaults* prefs = [NSUserDefaults standardUserDefaults];
    id billAmount = [prefs objectForKey: @"lastBillAmount"];
    NSInteger tipIndex = [prefs integerForKey: @"lastTipIndex"];
    NSDate* previousDate = [prefs objectForKey: @"lastBillDate"];
    
    // present billAmount, tipIndex
    // if < 10 m since last saved
    NSDate* now = [NSDate date];
    NSInteger interval = [now timeIntervalSinceDate: previousDate];
    if (interval < 600) {
        [self present:billAmount withIndex:tipIndex];
    } else {
        self.billTextField.text = @"";
    }
    [self updateValues:YES];
}

-(void) present:(id)billAmount withIndex:(NSInteger)tipIndex {
    [self.tipControl setSelectedSegmentIndex:tipIndex];
    self.billTextField.text = billAmount;
    
}


-(void) onApplicationWillResignActive {
    NSUserDefaults* prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject: self.billTextField.text forKey:@"lastBillAmount"];
    [prefs setInteger: self.tipControl.selectedSegmentIndex forKey:@"lastTipIndex"];
    [prefs setObject: [NSDate date] forKey: @"lastBillDate"];
    [prefs synchronize];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];
    // Do any additional setup after loading the view from its nib.

    [super viewDidLoad];
 
}

- (void) viewWillAppear:(BOOL)animated {
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    int index = (int)[defaults integerForKey:@"defaultTip"];
    [self.tipControl setSelectedSegmentIndex:index];
    [self updateValues:YES];
    if ([[self.billTextField text] isEqual:@""] ) {
        [self.billTextField becomeFirstResponder];
    }
    self.title = @"Tip Calculator";
    NSLog(@"home view will appear");
    [super viewWillAppear:animated];
}

-(void) viewDidAppear:(BOOL)animated {
    NSLog(@"home view did appear");
    [super viewDidAppear:animated];
}

-(void) viewWillDisappear:(BOOL)animated {
    NSLog(@"home view will disappear");
    [super viewWillDisappear:animated];
}

-(void) viewDidDisappear:(BOOL)animated {
    NSLog(@"home view did disappear");
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new ` controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
    [self updateValues:YES];
}

- (void)updateValues:(BOOL) animated {
    float billAmount = [self.billTextField.text floatValue];
    NSArray* tipValues = @[@(0.1), @(0.15), @(0.2)];
    float tipAmount = billAmount * [tipValues[self.tipControl.selectedSegmentIndex] floatValue];
    float totalAmount = billAmount + tipAmount;
    
    
    // set formatted locale strings
    NSNumberFormatter* nf = [[NSNumberFormatter alloc] init];
    [nf setNumberStyle:NSNumberFormatterCurrencyStyle];
    [nf setLocale:[NSLocale currentLocale]];
    
    NSString *locale = [[NSLocale currentLocale] localeIdentifier];
    NSLog(@"current locale : %@", locale);
    
    NSArray* preferredLangs = [NSLocale preferredLanguages];
    NSLog(@"preferred Langs : %@", preferredLangs);
//    NSLog(@" animated: %@", animated);
    if (animated) {
        [UIView animateWithDuration:0.4 animations:^{
            self.tipLabel.text = [nf stringFromNumber: [[NSNumber alloc] initWithFloat:tipAmount]];

            CGRect tipFrame = self.tipLabel.frame;
            tipFrame.origin.x = 300;
            self.tipLabel.frame = tipFrame;
            
            self.totalLabel.text = [nf stringFromNumber: [[NSNumber alloc] initWithFloat:totalAmount]];

            CGRect frame = self.totalLabel.frame;
            frame.origin.x = 300;
            self.totalLabel.frame = frame;
            
        } completion:^(BOOL finished) {
            
        }];
    } else {
        self.tipLabel.text = [nf stringFromNumber: [[NSNumber alloc] initWithFloat:tipAmount]];
        self.totalLabel.text = [nf stringFromNumber: [[NSNumber alloc] initWithFloat:totalAmount]];
    }
}

-(void) onSettingsButton {
    [self.navigationController pushViewController: [[SettingsViewController alloc] init] animated: YES];
}
@end
