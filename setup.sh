#!/usr/bin/env bash

set -e
set -x

git submodule update --init

rvm use 1.8.7%rails2.2
cd agility
git submodule update --init
rm -rf vendor/plugins/hobo
(cd vendor/plugins; ln -s ../../../hobo .)
rake db:migrate

cd ../hobo
git checkout origin/master

rvm use 1.8.7%rails2.3
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

cd ../agility-mysql
git branch mysql origin/mysql || true
git checkout mysql
git submodule update --init
rm -rf vendor/plugins/hobo
(cd vendor/plugins; ln -s ../../../hobo .)
cd ../hobo
git checkout origin/master
cd ../agility-mysql
rake db:migrate
rake db:migrate RAILS_ENV=test

rvm use jruby%rails2.3
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
ruby -S rake db:migrate
ruby -S rake db:migrate RAILS_ENV=test

rvm use 1.9.1%rails2.3
cd ../agility-1.9
git branch ruby1.9 origin/ruby1.9 || true
git checkout ruby1.9
git submodule update --init
rm -rf vendor/plugins/hobo
cd ../hobo
git checkout origin/master
cd ../agility-1.9
(cd vendor/plugins; ln -s ../../../hobo .)
ruby -S rake db:migrate
ruby -S rake db:migrate RAILS_ENV=test

cd ../hobo-test
git submodule update --init
rake db:migrate
rake db:migrate RAILS_ENV=test

cd ../hobo
git checkout origin/master