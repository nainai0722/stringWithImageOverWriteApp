//
//  ViewController.m
//  stringWithImageOverWriteApp
//
//  Created by apple on 2018/06/20.
//  Copyright © 2018年 com.nainai0722. All rights reserved.
//

#import "ViewController.h"
#import <Vision/Vision.h>
@interface ViewController ()

@end

@implementation ViewController
-(void) viewWillAppear:(BOOL)animated{

}
- (IBAction)touchImage:(UITapGestureRecognizer *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    if (self.imageName !=nil) {
        UIImage *replaceImage = [UIImage imageNamed:self.imageName];
        self.sampleImage.image = replaceImage;
    }
    
    CIImage *image = [[CIImage alloc] initWithImage:self.sampleImage.image];
    [self detectWithImage:image];
}


- (void)detectWithImage:(CIImage *)image
{

    VNImageRequestHandler *handler = [[VNImageRequestHandler alloc] initWithCIImage:image options:@{}];
    VNDetectTextRectanglesRequest *request = [[VNDetectTextRectanglesRequest alloc] initWithCompletionHandler:^(VNRequest * _Nonnull request, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error);
        }
        else {
            UIImage *img = [self overlayImageWithTextObservations:request.results size:CGSizeMake(self.sampleImage.image.size.width, self.sampleImage.image.size.height)];
            UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
            imgView.contentMode = UIViewContentModeScaleAspectFit;
            imgView.frame = self.sampleImage.frame;
            [self.view addSubview:imgView];
            for (VNTextObservation *textObservation in request.results) {
                                NSLog(@"textObservation %@", textObservation);
                                NSLog(@"textObservation.characterBoxes %@", textObservation.characterBoxes);
                NSLog(@"%@", NSStringFromCGRect(textObservation.boundingBox));
                
                
                
                for (VNRectangleObservation *rectangleObservation in textObservation.characterBoxes) {
                    NSLog(@" |-%@", NSStringFromCGRect(rectangleObservation.boundingBox));
                }
            }
        }
    }];
    request.reportCharacterBoxes = YES;
    NSError *error;
    [handler performRequests:@[request] error:&error];
    if (error) {
        NSLog(@"%@", error);
    }
}


- (UIImage *)overlayImageWithTextObservations:(NSArray<VNTextObservation *> *)results size:(CGSize)size
{
    UIGraphicsImageRenderer *renderer = [[UIGraphicsImageRenderer alloc] initWithSize:size];
    UIImage *overlayImage = [renderer imageWithActions:^(UIGraphicsImageRendererContext * _Nonnull rendererContext) {
        CGAffineTransform t = CGAffineTransformIdentity;
        t = CGAffineTransformScale(t, size.width, -size.height);
        t = CGAffineTransformTranslate(t, 0, -1);
        for (VNTextObservation *textObservation in results) {
            [[UIColor redColor] setStroke];
            [[UIBezierPath bezierPathWithRect:CGRectApplyAffineTransform(textObservation.boundingBox, t)] stroke];
            for (VNRectangleObservation *rectangleObservation in textObservation.characterBoxes) {
                [[UIColor blueColor] setStroke];
                [[UIBezierPath bezierPathWithRect:CGRectApplyAffineTransform(rectangleObservation.boundingBox, t)] stroke];
            }
        }
    }];
    return overlayImage;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
