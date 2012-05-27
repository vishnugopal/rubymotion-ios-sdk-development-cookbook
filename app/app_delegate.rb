class AppDelegate < StoryboardDelegate
  attr_reader :document

  def initializeRootViewController(viewController, forApplication:application, launchedWithOptions:launchOptions)
    documentsDirectory = NSFileManager.defaultManager.URLsForDirectory(NSDocumentDirectory, 
        inDomains: NSUserDomainMask).lastObject
    documentURL = documentsDirectory.URLByAppendingPathComponent("Cookbook.recipes")

    @document = CookbookDocument.alloc.initWithFileURL(documentURL)

    viewController.tap do |vc|
      vc.topViewController.dataSource = @document

      @document.openWithCompletionHandler(lambda { |success|
        if(success)
          vc.topViewController.tableView.reloadData
        else
          NSLog("Failed to open document")
        end
      }) 
    end
  end

  def application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
    newDocument = CookbookDocument.alloc.initWithFileURL(url)

    NSLog("New document opened")

    newDocument.openWithCompletionHandler(lambda { |success|
      if(success)
        NSLog("New document read in")
        self.document.addRecipesFromCookbook(newDocument)
      else
        NSLog("Failed to open new document: %@", url)
      end
    })
    
    true
  end
end
