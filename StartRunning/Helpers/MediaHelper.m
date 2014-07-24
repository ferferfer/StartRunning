//
//  MediaHelper.m
//  StartRunning
//
//  Created by Fernando Garcia Corrochano on 22/07/14.
//  Copyright (c) 2014 ironHack. All rights reserved.
//

#import "MediaHelper.h"
@import MediaPlayer;
@import AVFoundation;

@interface MediaHelper ()<AVSpeechSynthesizerDelegate>

@property	(nonatomic,strong)MPMusicPlayerController *musicPlayerController;
@property (nonatomic,strong)AVSpeechSynthesizer * syn;
@property	(nonatomic,strong)AVSpeechUtterance *speechWalk;
@property	(nonatomic,strong)AVSpeechUtterance *speechRun;
@property	(nonatomic)BOOL wasPlaying;

@end


@implementation MediaHelper


-(AVSpeechSynthesizer *)syn{
	if (_syn==nil) {
    _syn=[[AVSpeechSynthesizer alloc] init];
		_syn.delegate=self;
	}
	return _syn;
}

-(AVSpeechUtterance *)speechWalk{
	if (_speechWalk==nil) {
    _speechWalk=[[AVSpeechUtterance alloc]initWithString:@"Start Walking"];
		[_speechWalk setRate:AVSpeechUtteranceMinimumSpeechRate];
		[_speechWalk setVoice:[AVSpeechSynthesisVoice voiceWithLanguage:@"en-us"]];
	}
	return _speechWalk;
}

-(AVSpeechUtterance *)speechRun{
	if (_speechRun==nil) {
    _speechRun=[[AVSpeechUtterance alloc]initWithString:@"Start Running"];
		[_speechRun setRate:AVSpeechUtteranceMinimumSpeechRate];
		[_speechRun setVoice:[AVSpeechSynthesisVoice voiceWithLanguage:@"en-us"]];
	}
	return _speechRun;
}

-(MPMusicPlayerController *)musicPlayerController{
	if (_musicPlayerController==nil) {
    _musicPlayerController=[[MPMusicPlayerController alloc]init];
	}
	return _musicPlayerController;
}


-(void)VibrateAndSay:(NSString *)sentence{
	
	[self.musicPlayerController nowPlayingItem];
	AVAudioSession *audioSession = [AVAudioSession sharedInstance];
	if(audioSession.isOtherAudioPlaying){
		self.wasPlaying = YES;
	}
	if ([sentence isEqualToString:@"run"]) {
		[self.syn speakUtterance:self.speechRun];
	}else{
		[self.syn speakUtterance:self.speechWalk];
	}
	//Vibrate
	AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

-(void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance{
	if(self.wasPlaying){
		[self.musicPlayerController play];
	}
}


@end
