<?php
// Douban API Class V2
// Design for douban API v2

require_once("HTTP/Request2.php");
require_once(dirname(__FILE__) . "/douban.config.php");

class douban extends douban_config {
  // base class for douban_movie and douban_music
  // $id, $type, $api_url, $file_path, $image_path must be set correctly on subclass construction
  var $id = "";
  var $type = "";
  var $api_url = "";
  var $file_path = "";
  var $image_url = "";
  var $image_path = "";

  function __construct() {
    parent::__construct();
  }

  // Test if douban api cache is complete
  // return int state (0: not cached, 1: cached)
  function cache_state() {
    if (!file_exists($this->file_path)) {
      return 0;
    }
    @$fp = fopen($this->file_path, "r");
    if (!$fp) {
      return 0;
    }

    return 1;
  }

  // Test if douban image cache is complete
  // return int state (0: not cached, 1: cached)
  function image_state() {
    if (!file_exists($this->image_path)) {
      return 0;
    }
    @$fp = fopen($this->image_path, "r");
    if (!$fp) {
      return 0;
    }

    return 1;
  }

  // Return last cache time
  function get_cache_time() {
    $last = 0;

    if (file_exists($this->file_path)) {
      $last = filemtime($this->file_path);
    }

    return $last;
  }

  // Retrive douban object information via douban api in json format
  // return int state (0: fail, 1: sucess)
  function retrive() {
    $req = new HTTP_Request2("");
    $req->setURL($this->api_url);
    $res = $req->send();
    $resbody = $res->getBody();

    if ($resbody) {
      $jsonResult = $resbody;
    } else {
      return 0;
    }

    if ($jsonResult) {
      $fp = fopen($this->file_path, "w");
      fputs($fp, $jsonResult);
      fclose($fp);
      return 1;
    } else {
      return 0;
    }
  }

  // Get image from douban, save image from $this->image_url to $this->image_path
  // return boolean success
  function get_image() {
    $req = new HTTP_Request2("");
    $image_url = $this->image_url;

    if (!$image_url) {
      return FALSE;
    }

    $req->setUrl($image_url);
    $response = $req->send();

    if (strpos($response->getHeader("Content-Type"), 'image/jpeg') === 0 ||
      strpos($response->getHeader("Content-Type"), 'image/gif') === 0 ||
      strpos($response->getHeader("Content-Type"), 'image/bmp') === 0) {
      $fp = $response->getBody();
    } else {
      return false;
    }

    $fp2 = fopen($this->image_path, "w");
    if ((!$fp) || (!$fp2)) {
      echo "image error...<br />";
      return false;
    }
    fputs($fp2, $fp);

    return TRUE;
  }

  // Purge outdated douban cache file
  // This method looks for files older than the cache_expire set in the
  // douban_config and removes them
  function purge($explicit = false) {
    if (is_dir($this->cache_dir)) {
      $fname = $this->file_path;
      if (file_exists($fname)) {
        $now = time();
        $mod = filemtime($fname);
        if ($mod && (($now - $mod > $this->cache_expire) || $explicit == true)) {
          unlink($fname);
        }
      }
    }

    if (is_dir($this->image_dir)) {
      $fname = $this->image_path;
      if (file_exists($fname)) {
        $now = time();
        $mod = filemtime($fname);
        if ($mod && (($now - $mod > $this->cache_expire) || $explicit == true)) {
          unlink($fname);
        }
      }
    }
  }

}

// douban movie information container
class douban_movie extends douban {

  var $title = "";
  var $director = "";
  var $summary = "";
  var $year = "";
  var $type = array();
  var $duration = array();
  var $genre = array();
  var $language = array();
  var $country = array();
  var $aka = array();
  var $cast = array();
  var $pubdate = array();
  var $writer = array();
  var $tag = array();
  var $rating = "";
  var $raters = "";


  function __construct($id) {
    parent::__construct();
    $this->id = $id;
    $this->type = "movie";
    $this->file_path = $this->cache_dir . $this->type . '/' . $this->id . ".xml";
    $this->image_path = $this->image_dir . $this->type . '/' . $this->id . ".jpg";
    $this->api_url = $this->protocol_prefix . $this->douban_api_base . "v2/" . $this->type . "/subject/" . $this->id;//."?apikey=".$this->apikey;

    if ($this->cache_state() == 1) {
      $this->parse();
    }
  }

  // Obviously it's easy to parse json format's data, but for compatiable this function is still useful...
  function parse() {
    $jsonFile = $this->file_path;
    $xml = array();
    $movie = $this;

    $fp = fopen($jsonFile, 'r');
    $jsonData = fread($fp, filesize($jsonFile));
    $jsonObject = json_decode($jsonData);

    $movie->title = $jsonObject->title;
    $movie->summary = $jsonObject->summary;
    $movie->image_url = $jsonObject->images->large;
    $movie->director = $jsonObject->directors;
    $movie->year = $jsonObject->year;
    $movie->genre = $jsonObject->genres;
    $movie->aka = $jsonObject->aka;
    $movie->country = $jsonObject->countries;
    $movie->cast = $jsonObject->casts;

    $movie->rating = $jsonObject->rating;
    $movie->raters = $jsonObject->ratings_count;

    //api disallow
    //$movie->duration
    //$movie->language
    //$movie->pubdate
    //$movie->writer
    //api haven't
    //$movie->tag


    /*
    foreach($xml as $row)
    {
      switch($row['tag'])
      {
        case "TITLE":
          $movie->title = $row['value'];
          break;

        case "SUMMARY":
          $movie->summary = $row['value'];
          break;

        case "LINK":
          if($row['attributes']['REL'] == "image")
          {
            $movie->image_url = $row['attributes']['HREF'];
          }
          break;

        case "DB:ATTRIBUTE":
          switch($row['attributes']['NAME'])
          {
            case "director":
              $movie->director = $row['value'];
              break;
            case "year":
              $movie->year = $row['value'];
              break;
            case "movie_duration":
              array_push($movie->duration, $row['value']);
              break;
            case "movie_type":
              array_push($movie->genre, $row['value']);
              break;
            case "language":
              array_push($movie->language, $row['value']);
              break;
            case "aka":
              array_push($movie->aka, $row['value']);
              break;
            case "country":
              array_push($movie->country, $row['value']);
              break;
            case "pubdate":
              array_push($movie->pubdate, $row['value']);
              break;
            case "cast":
              array_push($movie->cast, $row['value']);
              break;
            case "writer":
              array_push($movie->writer, $row['value']);
              break;
            default:
              break;
          }
            break;

        case "DB:TAG":
          array_push($movie->tag, array($row['attributes']['NAME'], $row['attributes']['COUNT']));
          break;

        case "GD:RATING":
          $movie->rating = $row['attributes']['AVERAGE'];
          $movie->raters = $row['attributes']['NUMRATERS'];
          break;

        default:
          break;
      }
      // switch ends
    }
    // foreach ends
    */
  }
  // $this->parse() ends

}

// douban_movie ends


// douban music information container
class douban_music extends douban {

  var $title = "";
  var $summary = "";
  var $disc = "";
  var $type = "";
  var $publisher = array();
  var $singer = array();
  var $media = array();
  var $track = array();
  var $aka = array();
  var $pubdate = array();
  var $tag = array();
  var $rating = "";
  var $raters = "";


  function __construct($id) {
    parent::__construct();
    $this->id = $id;
    $this->type = "music";
    $this->file_path = $this->cache_dir . $this->type . '/' . $this->id . ".xml";
    $this->image_path = $this->image_dir . $this->type . '/' . $this->id . ".jpg";
    $this->api_url = $this->protocol_prefix . $this->douban_api_base . $this->type . "/subject/" . $this->id . "?apikey=" . $this->apikey;

    if ($this->cache_state() == 1) {
      $this->parse();
    }
  }

  // Parse cached xml file data into douban_music object
  function parse() {
    $xmlfile = $this->file_path;
    $xmlparser = xml_parser_create();
    $xml = array();
    $music = $this;

    $fp = fopen($xmlfile, 'r');
    $xmldata = fread($fp, filesize($xmlfile));

    xml_parse_into_struct($xmlparser, $xmldata, $xml);
    xml_parser_free($xmlparser);


    foreach ($xml as $row) {
      switch ($row['tag']) {
        case "TITLE":
          $music->title = $row['value'];
          break;

        case "SUMMARY":
          $music->summary = $row['value'];
          break;

        case "LINK":
          if ($row['attributes']['REL'] == "image") {
            $music->image_url = $row['attributes']['HREF'];
          }
          break;

        case "DB:ATTRIBUTE":
          switch ($row['attributes']['NAME']) {
            case "discs":
              $music->disc = $row['value'];
              break;
            case "version":
              $music->type = $row['value'];
              break;
            case "publisher":
              array_push($music->publisher, $row['value']);
              break;
            case "singer":
              array_push($music->singer, $row['value']);
              break;
            case "media":
              array_push($music->media, $row['value']);
              break;
            case "aka":
              array_push($music->aka, $row['value']);
              break;
            case "track":
              $music->track[$row['attributes']['INDEX']] = $row['value'];
              break;
            case "pubdate":
              array_push($music->pubdate, $row['value']);
              break;
            default:
              break;
          }
          break;

        case "DB:TAG":
          array_push($music->tag, array($row['attributes']['NAME'], $row['attributes']['COUNT']));
          break;

        case "GD:RATING":
          $music->rating = $row['attributes']['AVERAGE'];
          $music->raters = $row['attributes']['NUMRATERS'];
          break;

        default:
          break;
      }
      // switch ends
    }
    // foreach ends
  }
  // $this->parse() ends

}// douban_music ends