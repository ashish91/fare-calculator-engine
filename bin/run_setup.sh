#!/bin/bash
echo "Checking rvm"
echo
if ! type "rvm" > /dev/null; then
  echo "rvm command not found."
  echo
  echo "Installing rvm."
  echo
  \curl -sSL https://get.rvm.io | bash
fi

echo "Installing Ruby 2.7.4."
echo
rvm install 2.7.4
rvm use 2.7.4

echo "Installing bundler and other gems."
echo
gem install bundle
bundle

rspec specs
