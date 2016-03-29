//
//  SMBEndRoundScoring.m
//  Russian Railroads Companion
//
//  Created by Samuel Boyce on 3/7/16.
//  Copyright © 2016 Samuel Boyce. All rights reserved.
//

#import "SMBEndRoundScoring.h"

@interface SMBEndRoundScoring () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *xSiberScore;
@property (weak, nonatomic) IBOutlet UILabel *stPeterScore;
@property (weak, nonatomic) IBOutlet UILabel *kievScore;

@property (weak, nonatomic) IBOutlet UIPickerView *industryPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *turnOrderPicker;

@property (weak, nonatomic) IBOutlet UISwitch *revalSwitch;

@property (weak, nonatomic) IBOutlet UIButton *xSiberButton;
@property (weak, nonatomic) IBOutlet UIButton *stPeterButton;
@property (weak, nonatomic) IBOutlet UIButton *kievButton;
@property (weak, nonatomic) IBOutlet UIButton *xSiberUndoButton;
@property (weak, nonatomic) IBOutlet UIButton *stPeterUndoButton;
@property (weak, nonatomic) IBOutlet UIButton *kievUndoButton;

@property (nonatomic, strong) SMBRRDataSource *dataSource;

@end


@implementation SMBEndRoundScoring

-(void)viewWillAppear:(BOOL)animated
{
    self.dataSource = [SMBRRDataSource SMBRRSharedDataSource];
    
    [self displayScore];
    
    if (self.dataSource.player.xSiberianVal > 0)
    {
        self.xSiberButton.enabled = NO;
        self.xSiberUndoButton.hidden = NO;
    }
    
    if (self.dataSource.player.stPeterVal > 0)
    {
        self.stPeterButton.enabled = NO;
        self.stPeterUndoButton.hidden = NO;
    }
    
    if (self.dataSource.player.kievVal > 0)
    {
        self.kievButton.enabled = NO;
        self.kievUndoButton.enabled = NO;
    }
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.revalSwitch.on = self.dataSource.player.revalOn;
    
    self.industryPicker.delegate = self;
    self.turnOrderPicker.delegate = self;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if ([pickerView isEqual:self.industryPicker])
    {
        return 9;
    }
    else if ([pickerView isEqual:self.turnOrderPicker])
    {
        return 4;
    }
    
    return 0;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSArray *industryVals = @[@"1", @"2", @"3", @"5", @"10", @"15", @"20", @"25", @"30"];
    
    if ([pickerView isEqual:self.turnOrderPicker])
    {
        return [NSString stringWithFormat:@"%lu", row + 1];
    }
    else if ([pickerView isEqual:self.industryPicker])
    {
        return industryVals[row];
    }
    
    return nil;
}

- (IBAction)evalTokenSwitched:(id)sender
{
    self.dataSource.player.revalOn = self.revalSwitch.on;
}

- (IBAction)xSiberUndoTapped:(id)sender
{
    self.dataSource.player.score -= self.dataSource.player.xSiberianVal;
    [self displayScore];
    self.dataSource.player.xSiberianVal = 0;
    self.xSiberButton.enabled = YES;
}

- (IBAction)stPeterUndoTapped:(id)sender
{
    self.dataSource.player.score -= self.dataSource.player.stPeterVal;
    [self displayScore];
    self.dataSource.player.stPeterVal = 0;
    self.stPeterButton.enabled = YES;
}

- (IBAction)kievUndoTapped:(id)sender
{
    self.dataSource.player.score -= self.dataSource.player.kievVal;
    [self displayScore];
    self.dataSource.player.kievVal = 0;
    self.kievButton.enabled = YES;
}

- (IBAction)scoringCompleteTapped:(id)sender
{
    
}

-(void)displayScore
{
    self.scoreLabel.text = [NSString stringWithFormat:@"Total Score: %lu",self.dataSource.player.score];
    
    self.xSiberScore.text = [NSString stringWithFormat:@"%lu", self.dataSource.player.xSiberianVal];
    self.stPeterScore.text = [NSString stringWithFormat:@"%lu", self.dataSource.player.stPeterVal];
    self.kievScore.text = [NSString stringWithFormat:@"%lu", self.dataSource.player.kievVal];
}
@end





















