//
//  ViewController.m
//  sha256
//
//  Created by hayao on 2020/12/16.
//

#import "ViewController.h"
#import <CommonCrypto/CommonHMAC.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (NSString*)sha256:(NSString *)text{
    NSLog(@"%@", text);
    const char *s = (char *)[text UTF8String];
    NSData *keyData=[NSData dataWithBytes:s length:strlen(s)];
     
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(keyData.bytes, keyData.length, digest);
    NSData *out = [NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    NSString *hash = [self hexadecimalStringFromData:out];
    return hash;
    
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"{length=32,bytes=0x" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"}" withString:@""];
    return hash;
}

- (NSString *)hexadecimalStringFromData:(NSData *)data
{
    NSUInteger dataLength = data.length;
    if (dataLength == 0) {
        return nil;
    }

    const unsigned char *dataBuffer = data.bytes;
    NSMutableString *hexString  = [NSMutableString stringWithCapacity:(dataLength * 2)];
    for (int i = 0; i < dataLength; ++i) {
        [hexString appendFormat:@"%02x", dataBuffer[i]];
    }
    return [hexString copy];
}

- (IBAction)CalcHashButton:(id)sender {
    if ([_tv.text  isEqual: @""]) return;
    _hashedValue.text = [self sha256:_tv.text];
    [[UIPasteboard generalPasteboard] setValue:_hashedValue.text forPasteboardType:@"public.utf8-plain-text"];
    NSLog(@"%@", _hashedValue.text);
    _message.text = @"copied to the clipboard";
}
@end
