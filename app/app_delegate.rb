class AppDelegate < StoryboardDelegate
  def initializeRootViewController(viewController, forApplication:application, launchedWithOptions:launchOptions)
    documentsDirectory = NSFileManager.defaultManager.URLsForDirectory(NSDocumentDirectory, 
        inDomains: NSUserDomainMask).lastObject
    documentURL = documentsDirectory.URLByAppendingPathComponent("Cookbook.recipes")

    @document = CookbookDocument.alloc.initWithFileURL(documentURL)

    error = Pointer.new(:object)
    unless documentURL.checkResourceIsReachableAndReturnError(error)
      @document.saveToURL(documentURL, forSaveOperation: UIDocumentSaveForCreating, completionHandler: lambda { |success| })
    end

    viewController.tap do |vc|
      vc.topViewController.dataSource = @document

      if documentURL.checkResourceIsReachableAndReturnError(error)
        @document.openWithCompletionHandler(lambda { |success|
          if(success)
            vc.topViewController.tableView.reloadData
          else
            NSLog("Failed to open document")
          end
        }) 
      end
    end
  end
end
