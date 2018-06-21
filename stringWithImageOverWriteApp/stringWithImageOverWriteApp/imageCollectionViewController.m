//
//  imageCollectionViewController.m
//  stringWithImageOverWriteApp
//
//  Created by apple on 2018/06/20.
//  Copyright © 2018年 com.nainai0722. All rights reserved.
//

#import "imageCollectionViewController.h"
#import "ViewController.h"

@interface imageCollectionViewController ()

@end

@implementation imageCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

#define arrayTitle [NSArray arrayWithObjects: @"07a591acfecfd6c2533a4e247e308dd4.jpg",@"41155_1.jpg",@"c6d9dd26.jpg",@"laputa_____castle_in_the_sky___by_williamdickeson-d4ci9wl.jpg",@"mig.jpeg",nil]
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    UIImage* Cellimg = [UIImage imageNamed:[arrayTitle objectAtIndex:indexPath.row]];
    UIImageView *CellimgView = [[UIImageView alloc] initWithImage:Cellimg];
    CellimgView.contentMode = UIViewContentModeScaleAspectFit;
    [cell setBackgroundView:CellimgView];
    
    // Configure the cell
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
 */
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ViewController *vc = [[ViewController alloc] init];
    vc.imageName = [arrayTitle objectAtIndex:indexPath.row];
    [self presentViewController:vc animated:YES completion:nil];
    
    return YES;
}


/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
