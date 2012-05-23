class StoryboardDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    storyboard = UIStoryboard.storyboardWithName("Storyboard", bundle: NSBundle.mainBundle)
    viewController = storyboard.instantiateInitialViewController

    if self.respond_to?("initializeRootViewController:forApplication:launchedWithOptions:")
      viewController = initializeRootViewController(viewController, forApplication:application, launchedWithOptions:launchOptions) 
    end

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = viewController
    @window.makeKeyAndVisible

    true
  end
end