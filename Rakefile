desc "Execute and format tests"
task :test, :sdk, :formatting, :reporter do |t, args|
  sdk = args[:sdk] || 'iphonesimulator'
  formatting = args[:formatting] || 'test'
  reporter = args[:reporter] || nil
  
  cmd = "xcodebuild -workspace iosdemo.xcworkspace -scheme iosdemo -sdk #{sdk} test"
  cmd += " | xcpretty --color --#{formatting}"
  cmd += " --report #{reporter}" unless reporter.nil?

  sh cmd
end

