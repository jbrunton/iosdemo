# Podfile

# Select the appropriate platform below
# Specify the minimum supported iOS version (or later) required by Kiwi
platform :ios, '7.0'
# platform :osx

#
# Some other entries might already exist in the file
# ...
#

pod "AFNetworking", "~> 2.0"

# Add Kiwi as an exclusive dependency for the AmazingAppTests target
# target :iosdemoTests, :exclusive => true do
#    pod 'Kiwi'
# end

# If you're using Xcode 5 with a brand new project
# (XCTest based instead of OCUnit based) use this instead:
target :iosdemoTests, :exclusive => true do
   pod 'Specta', '~> 0.2.1'
   pod 'Expecta', '~> 0.2.3'
   pod 'OCMockito', '~> 1.1'
end

