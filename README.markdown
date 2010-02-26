This is the system test environment for
[Hobo](http://github.com/tablatom/hobo).

It's mostly a bunch of git submodules, so make sure to install them:

    git submodule update --init

This environment was designed for Ubuntu.  It will probably work on
any Linux, and may work on OS X and definitely will not work on
Windows.

To make testing different versions of RUBY and different sets of gems
easy, this environment uses the awesome tool
[rvm](http://rvm.beginrescueend.com/).

Install rvm as per instructions, and then install the rubies.   You'll
probably want to install some libraries before the rubies.

So it might go something like this after rvm is installed:

   rvm install readline
   rvm install openssl
   rvm install iconv
   rvm install zlib
   rvm install 1.8.7
   rvm install 1.9.1 -C --with-readline-dir=$rvm_path/usr
   rvm install jruby

Now import all of the gems required for each ruby.

   ./rvm-import.sh

It may fail on rubydoctest.  If so:

   cd rubydoctest
   rake gem
   rvm use 1.8.7%rails2.2
   gem install pkg/rubydoctest-1.1.3.gem
   rvm use 1.8.7%rails2.3
   gem install pkg/rubydoctest-1.1.3.gem
   rvm use 1.9.1%rails2.3
   gem install pkg/rubydoctest-1.1.3.gem
   rvm use jruby%rails2.3
   gem install pkg/rubydoctest-1.1.3.gem

This environment assumes that you have no password for root@localhost
for mysql.   (If that is the case, it would be useful to ensure that
root is only allowed on localhost, and/or that the mysql port is
firewalled).

After rvm and your ruby environments are set up, you can finish
setting up your test environment:

    ./setup.sh

And then you can run the tests:

    ./test.sh

If you're not running in Linux (and maybe if you are), you will have
to modify the config/selenium.yml file for each project to specify the
path to your browser(s).

If you test with IE6/7, the first test "Autocomplete and contributors"
will fail.  This is a problem with the test, not Hobo.  The second test
"Editors" is flaky.   In both cases the problem is properly waiting
for actions to complete before continuing the test.

On other browsers, the first two Selenium tests will occasionally
fail.  These are timing errors.  This happens infrequently enough that
increasing the margins isn't worth the slowdown.   If you are
experiencing consistent failures on any test, please report it.

To run the smoke test, first choose an environment:

    rvm use 1.8.7%rails2.3

And then run the smoke test:

    ./smoke_test.sh

The smoke test uninstall, build and install the hobo gems, so make
sure you're okay with that.

