suzuka-image-viewer
======

[![Build Status](https://secure.travis-ci.org/rnakano/suzuka-image-viewer.png?branch=master)](https://travis-ci.org/rnakano/suzuka-image-viewer)

This is a small web-based image viewer for iPad family.

# features
* No database. You can add images using `cp`, `scp` or `ln`!
* Standalone. No web servers (like Apache, Nginx) needed.

# setup
Make directory `public/img` include images.

```sh
mkdir public/img
```

Copy your images into `public/img`. 

Example:

```sh
$ tree public/img/my-book1
public/img/my-book1
├── 00-1.jpg
├── 00-2.jpg
```

Edit `config.yaml` file. Modify basic auth user and password.

Install libraries and start server.

```sh
$ rake update
$ rake start
```
