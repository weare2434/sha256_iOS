//
//  ViewController.h
//  sha256
//
//  Created by hayao on 2020/12/16.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *hashedValue;
@property (weak, nonatomic) IBOutlet UILabel *message;
@property (weak, nonatomic) IBOutlet UITextView *tv;

- (IBAction)CalcHashButton:(id)sender;


@end

