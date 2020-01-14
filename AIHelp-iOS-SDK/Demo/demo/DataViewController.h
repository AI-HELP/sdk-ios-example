
#import <UIKit/UIKit.h>

@interface DataViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *dataLabel;
@property (strong, nonatomic) IBOutlet UIButton *btnTest;
@property (strong, nonatomic) id dataObject;

-(IBAction) doTest:(id)sender;

@end

