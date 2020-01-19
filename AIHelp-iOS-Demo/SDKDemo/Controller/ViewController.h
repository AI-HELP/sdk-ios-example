
#import <UIKit/UIKit.h>
@interface ViewController : UITableViewController

@property(nonatomic,strong)UITextField  * txf_uid;
@property(nonatomic,strong)UITextField  * txf_uname;
@property(nonatomic,strong)UITextField  * txf_gname;
@property(nonatomic,strong)UITextField  * txf_serverid;
@property(nonatomic,strong)UITextField  * txf_ppid;//for Parse SDK, but Parse SDK is dead
@property(nonatomic,strong)UITextField  * txf_tags;//写入json字符串
@property(nonatomic,strong)UISwitch     * sw_local;//前端化开关
@property(nonatomic,strong)UISegmentedControl * sc_show;//FAQ右上角显示逻辑
@property(nonatomic,strong)UISegmentedControl * sc_logic;//点击FAQ右上角按钮进入的逻辑
@end

