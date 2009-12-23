#!/usr/bin/env bash

set -e
set -x

cd hobo/hobo
rake build
cd ../hobofields
rake build
cd ../hobosupport
rake build
cd ..

sudo gem install --no-rdoc --no-ri hobosupport/pkg/*.gem hobofields/pkg/*.gem hobo/pkg/*.gem
rm hobosupport/pkg/*.gem hobofields/pkg/*.gem hobo/pkg/*.gem

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
