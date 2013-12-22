desc "Execute and format tests"
task :test, :sdk, :formatting, :reporter do |t, args|
  default_sdk = 'iphonesimulator'
  sdk = args[:sdk] ||= default_sdk
  
  default_formatting = 'simple'  
  formatting = args[:formatting] ||= default_formatting
  
  default_reporter = nil
  reporter = args[:reporter] ||= default_reporter
  
  cmd = "xcodebuild -workspace iosdemo.xcworkspace -scheme iosdemo -sdk #{sdk} test"
  cmd += " | xcpretty --color --#{formatting}"
  cmd += " --report #{reporter}" if reporter

  puts "*** cmd: #{cmd}"
  
  sh cmd
end

