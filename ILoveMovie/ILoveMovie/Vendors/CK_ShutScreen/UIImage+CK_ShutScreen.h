//
//  UIImage+CK_ShutScreen.h
//  
//
//  Created by lanou3g on 15/10/26.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (CK_ShutScreen)<UIImagePickerControllerDelegate>

+ (instancetype)captureWithView:(UIView *)view;

+ (void)saveToPhotoAlbumWithImage:(UIImage *)image;
@end
