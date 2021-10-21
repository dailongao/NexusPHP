<?php

class douban_config {
  var $apikey;
  var $protocol_prefix;
  var $douban_api_base;
  var $cache_dir;
  var $image_dir;
  var $cache_expire;
  var $timeout;
  var $outdate_time;

  function __construct() {
    // douban api key
    $this->apikey = "0ff671fec102db6e2fe355fc4308924a";
    // protocol prefix
    $this->protocol_prefix = "http://";
    // the douban api server to use.
    $this->douban_api_base = "api.douban.com/";
    // cache_dir should be writable by the webserver. This doesn't need to be
    // under documentroot.
    $this->cache_dir = './douban/cache/';
    // images are stored here after calling image_url()
    // this needs to be under documentroot to be able to display them on your pages.
    $this->image_dir = './douban/image/';
    // automatically delete cached files older than X secs
    $this->cache_expire = 365 * 24 * 60 * 60;
    // TWEAKING OPTIONS:
    // timeout for retriving info, uint in second
    $this->timeout = 120;
    // out dated time for retrived info, (7 days for default)
    $this->outdate_time = 60 * 60 * 24 * 7;
  }
}