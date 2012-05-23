class AppDelegate < StoryboardDelegate
  def initializeRootViewController(viewController, forApplication:application, launchedWithOptions:launchOptions)
    viewController.tap do |vc|
      vc.topViewController.dataSource = Cookbook.new
    end
  end
end
