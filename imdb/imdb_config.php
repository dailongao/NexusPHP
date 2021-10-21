<?php
 #############################################################################
 # IMDBPHP                              (c) Giorgos Giagas & Itzchak Rehberg #
 # written by Giorgos Giagas                                                 #
 # extended & maintained by Itzchak Rehberg <izzysoft@qumran.org>            #
 # http://www.qumran.org/homes/izzy/                                         #
 # ------------------------------------------------------------------------- #
 # This program is free software; you can redistribute and/or modify it      #
 # under the terms of the GNU General Public License (see doc/LICENSE)       #
 #############################################################################

 /* $Id: imdb_config.php,v 1.3 2007/02/26 22:44:14 izzy Exp $ */

// the proxy to use for connections to imdb.
// leave it empty for no proxy.
// this is only supported with PEAR. 
define ('PROXY', "yq2.cc98.fun");
define ('PROXY_PORT', "808");
define ('PROXY_USERNAME', 'nhd');
define ('PROXY_PASSWORD', 'nhd');


/** Configuration part of the IMDB classes
 * @package Api
 * @class imdb_config
 */
class imdb_config {
  var $imdbsite;
  var $cachedir;
  var $usecache;
  var $storecache;
  var $cache_expire;
  var $photodir;
  var $photoroot;
  var $timeout;
  var $imageext;
  
  /** Constructor and only method of this base class.
   *  There's no need to call this yourself - you should just place your
   *  configuration data here.
   * @constructor imdb_config
   */
  function imdb_config(){
  	// protocol prefix
    $this->protocol_prefix = "https://";
    // the imdb server to use.
    // choices are us.imdb.com uk.imdb.com german.imdb.com and italian.imdb.com
    // the localized ones (i.e. italian and german) are only qualified to find
    // the movies IMDB ID -- but parsing for the details will fail at the moment.
    $this->imdbsite = "www.imdb.com";
    // cachedir should be writable by the webserver. This doesn't need to be
    // under documentroot.
    $this->cachedir = './imdb/cache';
    //whether to use a cached page to retrieve the information if available.
    $this->usecache = true;
    //whether to store the pages retrieved for later use.
    $this->storecache = true;
    // automatically delete cached files older than X secs
    $this->cache_expire = 365*24*60*60;
    // the extension of cached images
    $this->imageext = '.jpg';
    // images are stored here after calling photo_localurl()
    // this needs to be under documentroot to be able to display them on your pages.
    $this->photodir = './imdb/images/';
    // this is the URL to the images, i.e. start at your servers DOCUMENT_ROOT
    // when specifying absolute path
    $this->photoroot = './imdb/images/';
    // TWEAKING OPTIONS:
    // limit the result set to X movies (0 to disable, comment out to use default of 20)
    $this->maxresults = 5000;
    // timeout for retriving info, uint in second
    $this->timeout = 120;
    // out dated time for retrived info, (7 days for default)
    $this->outdate_time = 60*60*24*7;
    // search variants. Valid options are "sevec" and "moonface". Comment out
    // (or set to empty string) to use the default
    $this->searchvariant = "";
  }

}

require_once ("HTTP/Request2.php");

class IMDB_Request extends HTTP_Request2
{
  function IMDB_Request($url){
    parent::__construct($url);
    if ( PROXY != ""){
      $this->setConfig(array('proxy_host' => PROXY, 'proxy_port' => PROXY_PORT));
    }
    if (PROXY_USERNAME != "") {
      $this->setConfig(array('proxy_user' => PROXY_USERNAME, 'proxy_password' => PROXY_PASSWORD));
    }
    $this->setConfig('follow_redirects', false);
	$this->setHeader('Host','72.21.211.32');
	$this->setHeader('User-Agent','Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.8) Gecko/20100722 Firefox/3.6.8');
	$this->setHeader('Accept','text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8');
	$this->setHeader('Accept-Language','en-us,en;q=0.5');
	$this->setHeader('Accept-Encoding','deflate');
	$this->setHeader('Accept-Charset','ISO-8859-1,utf-8;q=0.7,*;q=0.7');
	$this->setHeader('Content-Type','application/x-www-form-urlencoded');
	$this->setHeader('Referer','72.21.211.32');
  }
}
?>
