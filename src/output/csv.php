<?php
namespace Output;
require_once dirname(realpath(__FILE__)) . DIRECTORY_SEPARATOR . 'output.php';

class csv implements output
{
	public function output(array $data, string $outputLocation = '/tmp/data.csv')
	{
		if (is_string($outputLocation) === false) {
            syslog(LOG_INFO, "Cannot write to file. Path given isn't a string");
            return false;
        }
        $ptr = fopen($outputLocation, 'w+');
        if ($ptr === false) {
			syslog(LOG_INFO, 'Unable to open file: ' . $outputLocation . ' for writing.');
			return false;
		}
        $int = (int) 0;
        foreach ($data as $val) {
            if ($int === 0) {
                fputcsv($ptr, array_keys($val));
            }
            fputcsv($ptr, $val);
            $int ++;
        }
        fclose($ptr);
        return true;
	}
}