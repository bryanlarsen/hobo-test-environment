#!/usr/bin/env bash

set +x

rubies=( 1.8.7%rails2.2 1.8.7%rails2.3 1.9.1%rails2.3 jruby%rails2.3 )

for spec in ${rubies[@]} ; do
  version=${rubies%%%*}
  gems=${rubies##*%}
  source rvm use ${version}
  source rvm gems create ${gems}
  source rvm use ${spec}
  rvm gems import ${spec}.gems
done
