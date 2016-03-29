//
//  SMBMidRoundScoring.m
//  Russian Railroads Companion
//
//  Created by Samuel Boyce on 3/4/16.
//  Copyright © 2016 Samuel Boyce. All rights reserved.
//

#import "SMBMidRoundScoring.h"

@interface SMBMidRoundScoring () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (nonatomic, strong) SMBRRDataSource *dataSource;
@property (weak, nonatomic) IBOutlet UIPickerView *trainPointsPickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *engineerPointsPickerView;
@property (weak, nonatomic) IBOutlet UIButton *applyScoreButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UILabel *pickerLabel;
@property (weak, nonatomic) IBOutlet UIButton *engineerPointsButton;
@property (weak, nonatomic) IBOutlet UIButton *trainPointsButton;
@property (weak, nonatomic) IBOutlet UIButton *plusThreeButton;
@property (weak, nonatomic) IBOutlet UIButton *plusFiveButton;
@property (weak, nonatomic) IBOutlet UIButton *plusTenButton;

@property (nonatomic, assign) BOOL trainPointsUp;
@property (nonatomic, assign) BOOL engPointsUp;

@end

@implementation SMBMidRoundScoring

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dataSource = [SMBRRDataSource SMBRRSharedDataSource];
    
    [self cancelButtonTapped:self];
    [self toggleButtons];
    self.scoreLabel.text = [NSString stringWithFormat:@"Total Score: %lu", self.dataSource.player.score];
    
    self.trainPointsUp = NO;
    self.engPointsUp = NO;
    
    self.trainPointsPickerView.delegate = self;
    self.engineerPointsPickerView.delegate = self;
}

#pragma mark Button Implementations

-(IBAction)plusThreeTapped:(id)sender
{
    [self updateScoreByAdding: 3];
}

-(IBAction)plusFiveTapped:(id)sender
{
    [self updateScoreByAdding: 5];
}

-(IBAction)plusTenTapped:(id)sender
{
    [self updateScoreByAdding: 10];
}

-(IBAction)engineerPointsTapped:(id)sender
{
    [self toggleButtons];
    [self toggleEngineerPicker];
    self.engPointsUp = YES;
    self.pickerLabel.text = @"Select the Values of your 4 engineers (0 for empty slots)";
}

-(IBAction)trainPointsButtonTapped:(id)sender
{
    [self toggleButtons];
    [self toggleTrainPicker];
    self.trainPointsUp = YES;
    self.pickerLabel.text = @"Select the Values of your 2 Most Valuable Trains (set one value to 0 if you only have 1 train)";
}

-(IBAction)cancelButtonTapped:(id)sender
{
    [self toggleButtons];
    [self toggleSpecialPickers];
    self.engineerPointsPickerView.hidden = YES;
    self.trainPointsPickerView.hidden = YES;
    self.trainPointsUp = NO;
    self.engPointsUp = NO;
}

-(IBAction)applyScoreButtonTapped:(id)sender
{
    NSUInteger scoreToAdd = 0;
    if (self.trainPointsUp)
    {
        for (NSUInteger i = 0; i < self.trainPointsPickerView.numberOfComponents; i++)
        {
            scoreToAdd += [self.trainPointsPickerView selectedRowInComponent:i];
        }
        [self updateScoreByAdding:scoreToAdd];
    }
    else if (self.engPointsUp)
    {
        for (NSUInteger i = 0; i < self.engineerPointsPickerView.numberOfComponents; i++)
        {
            scoreToAdd += [self.engineerPointsPickerView selectedRowInComponent:i];
        }
        [self updateScoreByAdding:scoreToAdd];
    }
    [self cancelButtonTapped:nil];
}

#pragma mark Helper Functions
-(void)updateScoreByAdding: (NSUInteger)addition
{
    self.dataSource.player.score += addition;
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Total Score: %lu", self.dataSource.player.score];
}

-(void)toggleTrainPicker
{
    self.trainPointsPickerView.hidden = !self.trainPointsPickerView.hidden;
    [self toggleSpecialPickers];
}

-(void)toggleEngineerPicker
{
    self.engineerPointsPickerView.hidden = !self.engineerPointsPickerView.hidden;
    [self toggleSpecialPickers];
}

-(void)toggleSpecialPickers
{
    self.pickerLabel.hidden = !self.pickerLabel.hidden;
    self.applyScoreButton.hidden = !self.applyScoreButton.hidden;
    self.cancelButton.hidden = !self.cancelButton.hidden;
}

-(void)toggleButtons
{
    self.plusThreeButton.enabled = !self.plusThreeButton.enabled;
    self.plusFiveButton.enabled = !self.plusFiveButton.enabled;
    self.plusTenButton.enabled = !self.plusTenButton.enabled;
    self.engineerPointsButton.enabled = !self.engineerPointsButton.enabled;
    self.trainPointsButton.enabled = !self.trainPointsButton.enabled;
}

#pragma mark Picker View Setup
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if ([pickerView isEqual: self.trainPointsPickerView])
    {
        return 2;
    }
    else if ([pickerView isEqual: self.engineerPointsPickerView])
    {
        return 4;
    }
    
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if ([pickerView isEqual: self.trainPointsPickerView])
    {
        return 10;
    }
    else if ([pickerView isEqual: self.engineerPointsPickerView])
    {
        return 16;
    }
    
    return 1;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if ([pickerView isEqual: self.trainPointsPickerView])
    {
        return [NSString stringWithFormat:@"%lu", row];
    }
    else if ([pickerView isEqual: self.engineerPointsPickerView])
    {
        return [NSString stringWithFormat:@"%lu", row];
    }
    
    return nil;
}

@end




















