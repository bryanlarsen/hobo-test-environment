This is the system test environment for
[Hobo](http://github.com/tablatom/hobo).

This environment was designed for Ubuntu.  It will probably work on
any Linux, and may work on OS X and definitely will not work on
Windows.

This environment requires ruby 1.8 to be available in the path as
"ruby", ruby 1.9 as "ruby1.9.1" and jruby as "jruby".  Many gems are
required, install until you stop getting error messages.  In ubuntu,
it's as simple as

    sudo apt-get install ruby1.9.1-full
    sudo apt-get install sun-java6-bin 

I then downloaded jruby 1.4 from debian:
http://packages.debian.org/sid/all/jruby/download and installed it
(using `dpkg -i`).

Here's the list of gems you will need to install for jruby -- other
ruby's would be similar.

    sudo jruby -S gem install --no-rdoc --no-ri -v 2.3.4 rails
    sudo jruby -S gem install --no-rdoc --no-ri rake BlueCloth
    RedCloth jeweler rubigen will_paginate test-unit
    webrat josevalim-nested_scenarios activerecord-jdbc-adapter
    jdbc-sqlite3 activerecord-jdbcsqlite3-adapter
    activerecord-jdbcmysql-adapter jdbc-mysql

You will require my version of rubydoctest, which I've included:

    cd rubydoctest
    rake gem
    sudo jruby -S gem install pkg/rubydoctest-1.1.3.gem 

This environment assumes that you have no password for root@localhost
for mysql.

After cloning this environment and installing ruby1.9.1 and jruby, run
the setup.sh script.

    ./setup.sh

And then you can run the tests:

    ./test_all.sh

or

    ./smoke_test.sh
