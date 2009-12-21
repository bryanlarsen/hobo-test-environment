#!/usr/bin/env bash

set -e
set -x

function acceptance {
    $1 -S rake hobo:generate_taglibs
    $1 script/server -e test -p 3002 &
    pid=$!
    sleep 25
    $2 -S rake test:acceptance
    kill $pid || true
    sleep 1
    kill -9 $pid || true
}

function integration {
    $1 -S rake hobo:generate_taglibs
    $1 -S rake --trace test:integration
}

cd hobo
cd ../hobo                ; rake --trace test_all
cd ../agility             ; integration ruby
cd ../agility             ; acceptance ruby ruby
cd ../hobo                ; jruby -S rake --trace test_all
cd ../hobo                ; ruby1.9.1 -S rake --trace test_all
cd ../agility-jruby       ; integration jruby
cd ../agility-1.9/vendor/plugins; ln -sf ../nested_scenarios.git nested_scenarios ; cd ../..
cd ../agility-1.9         ; integration ruby1.9.1
cd ../hobo-test           ; integration ruby ruby
cd ../hobo-test           ; integration ruby1.9.1 ruby1.9.1
cd ../agility-2.3         ; integration ruby
cd ../agility-2.3         ; acceptance ruby ruby
#cd ../agility-jquery-2.3  ; acceptance ruby ruby
cd ../agility-jruby       ; acceptance jruby ruby
rm -f ../agility-1.9/vendor/plugins/nested_scenarios
cd ../agility-1.9          ; acceptance ruby1.9.1 ruby1.9.1
#cd ../agility-jquery      ; acceptance

echo "DONE!"
