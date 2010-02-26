#!/usr/bin/env bash

rubies=( 1.8.7%rails2.2 1.8.7%rails2.3 1.9.1%rails2.3 jruby%rails2.3 )

for spec in ${rubies[@]} ; do
  version=${rubies%%%*}
  gems=${rubies##*%}
  source rvm use ${spec}
  rvm gems export ${spec}.gems
done
  
