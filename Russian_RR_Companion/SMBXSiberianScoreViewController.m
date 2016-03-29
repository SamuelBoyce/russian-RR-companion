//
//  SMBXSiberianScoreViewController.m
//  Russian_RR_Companion
//
//  Created by Samuel Boyce on 3/21/16.
//  Copyright © 2016 Samuel Boyce. All rights reserved.
//

#import "SMBXSiberianScoreViewController.h"

@interface SMBXSiberianScoreViewController () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIPickerView *trackValuePicker;
@property (weak, nonatomic) IBOutlet UIPickerView *trainValuePicker;
@property (weak, nonatomic) IBOutlet UIPickerView *doublersPicker;

@property (nonatomic, strong) SMBRRDataSource *dataSource;

@property (nonatomic, assign) NSUInteger blackTracks;
@property (nonatomic, assign) NSUInteger grayTracks;
@property (nonatomic, assign) NSUInteger brownTracks;
@property (nonatomic, assign) NSUInteger naturalTracks;
@property (nonatomic, assign) NSUInteger whiteTracks;

@end

@implementation SMBXSiberianScoreViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.trackValuePicker.delegate = self;
    self.trainValuePicker.delegate = self;
    self.doublersPicker.delegate = self;
    
    self.dataSource = [SMBRRDataSource SMBRRSharedDataSource];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if ([pickerView isEqual:self.trackValuePicker])
    {
        return 5;
    }
    else
    {
        return 1;
    }
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if ([pickerView isEqual:self.trackValuePicker])
    {
        return 16 - component;
    }
    else if ([pickerView isEqual:self.trainValuePicker])
    {
        return 15;
    }
    else if ([pickerView isEqual:self.doublersPicker])
    {
        return 9;
    }
    
    return 1;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if ([pickerView isEqual:self.trainValuePicker])
    {
        return [NSString stringWithFormat:@"%lu", row + 1];
    }
    else
    {
        return [NSString stringWithFormat:@"%lu", row];
    }
}

- (IBAction)applyScoreTapped:(id)sender
{
    [self calcScore];
}

-(void)calcScore
{
    self.blackTracks   = [self.trackValuePicker selectedRowInComponent:0];
    self.grayTracks    = [self.trackValuePicker selectedRowInComponent:1];
    self.brownTracks   = [self.trackValuePicker selectedRowInComponent:2];
    self.naturalTracks = [self.trackValuePicker selectedRowInComponent:3];
    self.whiteTracks   = [self.trackValuePicker selectedRowInComponent:4];
    
    if ([self tracksInvalid])
    {
        UIAlertController *invalidTrackAlert = [UIAlertController alertControllerWithTitle:@"Invalid Track Selection" message:@"The track values you have selected do not conform to valid game rules" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        
        [invalidTrackAlert addAction:okButton];
        [self presentViewController:invalidTrackAlert animated:YES completion:nil];
        
        return;
    }
    
    NSUInteger trainValue  = [self.trainValuePicker selectedRowInComponent:0] + 1;
    NSUInteger numDoublers = [self.doublersPicker selectedRowInComponent:0];
    
    NSUInteger scoreToAdd = 0;
    
    for (NSUInteger i = 1; i <= trainValue; i++)
    {
        if (self.dataSource.player.revalOn)
        {
            NSUInteger scorePlus = 0;
            if (self.whiteTracks >= i)
            {
                scorePlus += 10;
            }
            else if (self.naturalTracks >= i)
            {
                scorePlus += 6;
            }
            else if (self.brownTracks >= i)
            {
                scorePlus += 3;
            }
            else if (self.grayTracks >= i)
            {
                scorePlus += 1;
            }
            
            if (numDoublers >= i)
            {
                scorePlus *= 2;
            }
            
            scoreToAdd += scorePlus;
        }
        else if (!self.dataSource.player.revalOn)
        {
            NSUInteger scorePlus = 0;
            if (self.whiteTracks >= i)
            {
                scorePlus += 7;
            }
            else if (self.naturalTracks >= i)
            {
                scorePlus += 4;
            }
            else if (self.brownTracks >= i)
            {
                scorePlus += 2;
            }
            else if (self.grayTracks >= i)
            {
                scorePlus += 1;
            }
            
            if (numDoublers >= i)
            {
                scorePlus *= 2;
            }
            
            scoreToAdd += scorePlus;
        }
    }
    
    self.dataSource.player.xSiberianVal = scoreToAdd;
    self.dataSource.player.score += scoreToAdd;
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL)tracksInvalid
{
    if ((self.grayTracks >= self.blackTracks && self.grayTracks + self.blackTracks > 0)       ||
        (self.brownTracks >= self.grayTracks && self.brownTracks + self.grayTracks > 0)       ||
        (self.naturalTracks >= self.brownTracks && self.naturalTracks + self.brownTracks > 0) ||
        (self.whiteTracks >= self.naturalTracks && self.whiteTracks + self.naturalTracks > 0))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

@end






















