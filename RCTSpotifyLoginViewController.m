//
//  RCTSpotifyLoginViewController.m
//
//  Created by Focal55 on 1/28/2017.
//

#import "RCTSpotifyLoginViewController.h"
#import "RCTSpotify.h"

@interface RCTSpotifyLoginViewController () <WKNavigationDelegate>
@property (strong, nonatomic) WKWebView *webView;
@property(nonatomic) NSURL *login;

@end

@implementation RCTSpotifyLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    _webView = [[WKWebView alloc] initWithFrame:self.view.frame
                                  configuration:configuration];
    _webView.navigationDelegate = self;
    _webView.allowsBackForwardNavigationGestures = true;
    
    [self setTitle:@"Log In"];
    //This creates a Done Button on the top left corner of the view
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                          target:self
                                                                                          action:@selector(hideTheThing)];
    
    // Load the login URL into the WKWebView
    [_webView loadRequest:[NSURLRequest requestWithURL:_login]];
    self.view = _webView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)hideTheThing {
    RCTSpotify *delegate = (RCTSpotify *)[[UIApplication sharedApplication] delegate];
    [delegate.window.rootViewController dismissViewControllerAnimated:YES completion:nil];
}

- (instancetype)initWithURL:(NSURL *)url
{
    _login = url;
    return self;
}


- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    RCTSpotify *sharedManager = [RCTSpotify sharedManager];
    NSURL *url = navigationAction.request.URL;
    NSLog(@"WEBVIEW URL: %@", url);
    NSURL *redirectUrl = [sharedManager redirectURL];
    
    //Set myScheme to your own Url Scheme
    NSString *scheme = [redirectUrl.absoluteString stringByReplacingOccurrencesOfString:@"://callback" withString:@""];
    NSLog(@"SCHEME: %@", scheme);
    if ([url.scheme isEqualToString:scheme]) {
        NSLog(@"WE GOT HERE");
        [self hideTheThing];
        [sharedManager urlCallback:url];
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

@end
