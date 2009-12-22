#!/usr/bin/env bash

set -e
set -x

git submodule update --init

cd agility
git submodule update --init
rm -rf vendor/plugins/hobo
(cd vendor/plugins; ln -s ../../../hobo .)
rake db:migrate

cd ../hobo
git checkout origin/master

cd ../agility-2.3
git branch rails2.3 origin/rails2.3 || true
git checkout rails2.3
git submodule update --init
rm -rf vendor/plugins/hobo
(cd vendor/plugins; ln -s ../../../hobo .)
cd ../hobo
git checkout origin/master
cd ../agility-2.3
rake db:migrate
rake db:migrate RAILS_ENV=test


cd ../agility-jruby
git branch jruby origin/jruby || true
git checkout jruby
git submodule update --init
rm -rf vendor/plugins/hobo
(cd vendor/plugins; ln -s ../../../hobo .)
cd ../hobo
git checkout origin/master
cd ../agility-jruby
mysqladmin -u root create agility_jruby_test || true
mysqladmin -u root create agility_jruby_development || true
jruby -S rake db:migrate
jruby -S rake db:migrate RAILS_ENV=test

cd ../agility-1.9
git branch ruby1.9 origin/ruby1.9 || true
git checkout ruby1.9
git submodule update --init
rm -rf vendor/plugins/hobo
cd ../hobo
git checkout origin/master
cd ../agility-1.9
(cd vendor/plugins; ln -s ../../../hobo .)
ruby1.9.1 -S rake db:migrate
ruby1.9.1 -S rake db:migrate RAILS_ENV=test

cd ../hobo-test
git submodule update --init
rake db:migrate
rake db:migrate RAILS_ENV=test

cd ../hobo
git checkout origin/master