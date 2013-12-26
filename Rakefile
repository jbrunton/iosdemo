desc "Execute and format unit tests"
task 'kiwi:test', :sdk, :formatting, :reporter do |t, args|
  sdk = args[:sdk] || 'iphonesimulator'
  formatting = args[:formatting] || 'test'
  reporter = args[:reporter] || nil
  
  cmd = "xcodebuild -workspace iosdemo.xcworkspace -scheme iosdemo -sdk #{sdk} test"
  cmd += " | xcpretty --color --#{formatting}"
  cmd += " --report #{reporter}" unless reporter.nil?

  sh cmd
end

desc "Frankify build"
task 'frank:build' do
  cmd = "frank build --workspace iosdemo.xcworkspace -scheme iosdemo"
  sh cmd
end

desc "Run Frank tests"
task 'frank:test' do
  Dir.chdir('Frank') do
    sh "cucumber"
  end
end

desc "Run all tests"
task 'test' => ['kiwi:test', 'frank:build', 'frank:test']
