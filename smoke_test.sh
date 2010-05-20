#!/usr/bin/env bash

set -x

gem uninstall hobo -x
gem uninstall hobofields -x
gem uninstall hobosupport -x

cd hobo/hobo
rake build
cd ../hobofields
rake build
cd ../hobosupport
rake build
cd ..

set -e

VERSION=1.0.1

gem install --no-rdoc --no-ri hobosupport/pkg/hobosupport-${VERSION}.gem hobofields/pkg/hobofields-${VERSION}.gem hobo/pkg/hobo-${VERSION}.gem
rm hobosupport/pkg/hobosupport-${VERSION}.gem hobofields/pkg/hobofields-${VERSION}.gem hobo/pkg/hobo-${VERSION}.gem

cd ..
hobo smoke
cd smoke
ruby script/generate hobo_model_resource thing name:string body:text
echo "m" > response.txt
echo "" >> response.txt
ruby script/generate hobo_migration < response.txt

ruby script/server -p 3003 &
pid=$!
sleep 15

wget http://localhost:3003/
grep "Things" index.html
grep "Smoke" index.html
grep "Congratulations" index.html

cd ..
rm -rf smoke

kill $pid || true
sleep 1
kill -9 $pid || true
exit 0
