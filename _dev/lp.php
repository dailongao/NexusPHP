<?php

if(count($argv) == 4)
    analyze_logs($argv[1],$argv[2],$argv[3]);
else
{
    echo "error, " . (count($argv)-1). "arguments provides";
    echo "please provide 3 arguments, e.g. \n";
    echo "php pl.php 30 30 H:/sr/log/apache/access.log";
    die();
}

function analyze_logs($start_log_idx, $end_log_idx,$logname_base) 
{
    for($i = $start_log_idx; $i >= $end_log_idx; --$i)
    {
	$logname_in = $logname_base . "." . $i;
	$logname_out =  $logname_base . "." . $start_log_idx . "_" . $end_log_idx;
	analyze_log($logname_in,$logname_out);
    }
}

function analyze_log($logname_in, $logname_out)
{
    echo "-----" . "start parsing for log " . $logname_in . "-----" . "\n";
    $handle = @fopen($logname_in, "r");
    $handle_z = @fopen($logname_out . "_zhangyoufu", "a");
    $handle_s = @fopen($logname_out . "_summary", "a");
    if ($handle && $handle_z && $handle_s)
    {
	$ip_arr = array();
	$line_counter = 1;
	while (($line = fgets($handle)) !== false)
	{
	    // possible actions taken by zhangyoufu
	    if(stristr($line, 'a60e19a6f349106e69fcf8be491fb1ed') !== FALSE ||
	       stristr($line, 'highdefhdsqsql') !== FALSE ||
	       stristr($line, '/include/browser/browser.php') !== FALSE ||
	       stristr($line, '/include/smtp/smtp.const.php') !== FALSE ||
	       stristr($line, 'test1.php') !== FALSE ||
	       stristr($line, 'test2.php') !== FALSE ||
	       stristr($line, 'test3.php') !== FALSE ||
	       stristr($line, 'test4.php') !== FALSE)
	    {
		// get ip
		$line_exp = explode(" - - ",$line);
		$ip_arr[] = trim($line_exp[0]);
		//echo $line_exp[0] . "\n";
	    }
	    
	    if(($line_counter++)%100000==1)
		echo "analyzing at line #" . ($line_counter - 1) . ", for log " . $logname_in . "\n";
	}
	if (!feof($handle)) {
	    echo "Error: unexpected fgets() fail\n";
	}
	
	// possible distinct ips used by zhangyoufu
	$ip_arr_distinct = array();	// reset keys to 0,1,2...
	$ip_arr_distinct = array_values(array_unique($ip_arr));
	print_r($ip_arr_distinct);
	
	$ip_arr_distinct_evil_actions = array(); // reset keys to 0,1,2...
	$ip_arr_distinct_evil_actions = array_fill(0, count($ip_arr_distinct), 0);
	print_r($ip_arr_distinct_evil_actions);
	
	$ip_arr_distinct_potentially_evil_actions = array(); // reset keys to 0,1,2...
	$ip_arr_distinct_potentially_evil_actions = array_fill(0, count($ip_arr_distinct), 0);
	print_r($ip_arr_distinct_potentially_evil_actions);
	
	$ip_arr_distinct_total_actions = array(); // reset keys to 0,1,2...
	$ip_arr_distinct_total_actions = array_fill(0, count($ip_arr_distinct), 0);
	print_r($ip_arr_distinct_total_actions);
	
	// rewind to the begining and collect actions
	rewind($handle);
	$line_counter = 1;
	fwrite($handle_z, "-----" . "refined actions for log " . $logname_in . "-----" . "\n");
	while (($line = fgets($handle)) !== false)
	{
	    $ip_ismatched = false;
	    $k = -1;
	    foreach ($ip_arr_distinct as $k => &$ip)
	    {
		$ip_of_line = explode(" - - ",$line);
		if($ip == trim($ip_of_line[0]))
		{
		    $ip_ismatched = true;
		    break;
		}
	    }
	    
	    // collect matched actions and count for the evilness and goodness
	    if($ip_ismatched)
	    {
		fwrite($handle_z, $line);
		
		if(stristr($line, 'highdefhdsqsql') !== FALSE ||
		   stristr($line, '/include/browser/browser.php') !== FALSE ||
		   stristr($line, '/include/smtp/smtp.const.php') !== FALSE ||
		   stristr($line, 'test1.php') !== FALSE ||
		   stristr($line, 'test2.php') !== FALSE ||
		   stristr($line, 'test3.php') !== FALSE ||
		   stristr($line, 'test4.php') !== FALSE)
		{
		    ++$ip_arr_distinct_evil_actions[$k];
		}
		else if(stristr($line, 'thanks.php') !== FALSE ||
			stristr($line, 'Wget') !== FALSE ||
			stristr($line, 'phpmyadmin') !== FALSE ||
			stristr($line, 'webalizer') !== FALSE ||
			stristr($line, 'munin') !== FALSE)
		{
		    ++$ip_arr_distinct_potentially_evil_actions[$k];
		}
		++$ip_arr_distinct_total_actions[$k];
	    }
	    
	    if(($line_counter++)%100000==1)
		echo "collecting at line #" . ($line_counter - 1) . ", for log " . $logname_in . "\n";
	}
	
	// write summary
	fwrite($handle_s, "-----" . "summary report for log " . $logname_in . "-----" . "\n");
	foreach ($ip_arr_distinct as $k => &$ip)
	{
	    $ip_and_evilidx = $ip .
	    " " . $ip_arr_distinct_total_actions[$k] .
	    " " . $ip_arr_distinct_evil_actions[$k] .
	    " " . $ip_arr_distinct_potentially_evil_actions[$k] . "\n";
	    fwrite($handle_s, $ip_and_evilidx);
	}
	
	fclose($handle);
	fclose($handle_z);
	fclose($handle_s);
    }
    echo "-----" . "pasing complete for log " . $logname_in . "-----" . "\n";
}

?>