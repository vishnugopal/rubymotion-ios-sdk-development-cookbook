$:.unshift("/Library/RubyMotion/lib")
require 'motion/project'

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'recipes'
  app.files = Dir.glob("./lib/*.rb") + Dir.glob("./lib/*/*.rb") + app.files
  app.files_dependencies 'app/app_delegate.rb' => 'app/storyboard_delegate.rb'
  app.files_dependencies 'app/models/cookbook_document.rb' => 'app/models/recipe.rb'

  app.frameworks += ["MessageUI"]

  # <key>UTExportedTypeDeclarations</key>
  # <array>
  #     <dict>
  #         <key>UTTypeIdentifier</key>
  #         <string>public.jpeg</string>
  #         <key>UTTypeReferenceURL</key>
  #         <string>http://www.w3.org/Graphics/JPEG/</string>
  #         <key>UTTypeDescription</key>
  #         <string>JPEG image</string>
  #         <key>UTTypeIconFile</key>
  #         <string>public.jpeg.icns</string>
  #         <key>UTTypeConformsTo</key>
  #         <array>
  #             <string>public.image</string>
  #             <string>public.data</string>
  #         </array>
  #         <key>UTTypeTagSpecification</key>
  #         <dict>
  #             <key>com.apple.ostype</key>
  #             <string>JPEG</string>
  #             <key>public.filename-extension</key>
  #             <array>
  #                 <string>jpeg</string>
  #                 <string>jpg</string>
  #             </array>
  #             <key>public.mime-type</key>
  #             <string>image/jpeg</string>
  #         </dict>
  #     </dict>
  # </array>


  uti_declarations = [
    {
      "UTTypeIdentifier" => "com.pragprog.adios.recipes",
      "UTTypeDescription" => "Recipe Data",
      "UTTypeConformsTo" => [
        "public.data"
      ],
      "UTTypeTagSpecification" => {
        "public.mime-type" => "application/octet-stream",
        "public.filename-extension" => [
          "recipes"
        ]
      }
    }
  ]

  app.info_plist["UTExportedTypeDeclarations"] = uti_declarations

  # <key>CFBundleDocumentTypes</key>
  # <array>
  #   <dict>
  #      <key>CFBundleTypeName</key>
  #      <string>My File Format</string>
  #      <key>CFBundleTypeIconFiles</key>
  #          <array>
  #              <string>MySmallIcon.png</string>
  #              <string>MyLargeIcon.png</string>
  #          </array>
  #      <key>LSItemContentTypes</key>
  #          <array>
  #              <string>com.example.myformat</string>
  #          </array>
  #      <key>LSHandlerRank</key>
  #      <string>Owner</string>
  #   </dict>
  # </array>

  document_types = [
    {
      "CFBundleTypeName" => "Recipe Document",
      "LSItemContentTypes" => [
        "com.pragprog.adios.recipes"
      ],
      "LSHandlerRank" => "Owner"
    }
  ]

  app.info_plist["CFBundleDocumentTypes"] = document_types

end
