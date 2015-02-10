
A Docker image for developing PHP app using PHP-FPM and nginx.

Usages
------

Put an `index.php` file under project root directory with:

        <?php
        print phpinfo();

Then

        # put your SSH pubkey at `mykey.pub` if you want SSH access
        $ make build run
        # check http://localhost:8080/

If you use [boot2docker](http://boot2docker.io/) replace `localhost` with the IP reported by `boot2docker ip`.

### SSH access

This image follows the practice of [Phusion baseimage](https://github.com/phusion/baseimage-docker#login_ssh) in regard of SSH access.  It contains a SSH publick key of my own.  So if you are using it for your production site, *build from this image and replace the public key with your own*.
