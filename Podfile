target 'Flash Chat iOS13'
  
  post_install do |installer|
   installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
     config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
    end
   end
  end
  
  use_frameworks!





  # Pods for Flash Chat iOS13
  pod 'Firebase/Auth'
  pod 'Firebase/Firestore'
 
 
 
