#import <UIKit/UIKit.h>

@interface YYLabel : UIView
@property(nonatomic, copy, readwrite) NSString *text;
@property(nonatomic, assign) BOOL messageEditTweak;
@end

%hook YYLabel
%property(nonatomic, assign) BOOL messageEditTweak;
-(void)setFrame:(CGRect)arg1 {
	%orig;
	if (!self.messageEditTweak) {
		if ([self.superview.superview.superview.superview.superview.superview class] == objc_getClass("DCDMessageTableViewCell")) {
			self.messageEditTweak = YES;
			UITapGestureRecognizer *editTweakRecogniser = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTweakEditTapGesture:)];
			editTweakRecogniser.numberOfTapsRequired = 2;
			[self addGestureRecognizer:editTweakRecogniser];
		}   
	}
}

%new
- (void)handleTweakEditTapGesture:(UITapGestureRecognizer *)sender {
	if (sender.state == UIGestureRecognizerStateRecognized) {
		NSString *alertMessage = [NSString stringWithFormat:@"Current text:\n\n%@", self.text];
		UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"no tories allowed lmao" message:alertMessage preferredStyle:UIAlertControllerStyleAlert];

		[alert addTextFieldWithConfigurationHandler:^(UITextField *_Nonnull textField) {
			textField.autocorrectionType = UITextAutocorrectionTypeYes;
			textField.placeholder = @"Enter new message text";
		}];

		UIAlertAction *editButton = [UIAlertAction actionWithTitle:@"Edit" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
			self.text = alert.textFields[0].text;
		}];

		[alert addAction:editButton];

		[[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:alert animated:YES completion:nil];
	}
}
%end
