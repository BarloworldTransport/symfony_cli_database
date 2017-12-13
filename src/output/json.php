<?php
namespace Output;
require_once dirname(realpath(__FILE__)) . DIRECTORY_SEPARATOR . 'output.php';


class json implements output
{
	public function output(array $data, string $outputLocation = '/tmp/data.json'): bool
	{

		$encoded = json_encode($data, JSON_PRETTY_PRINT);
		if (json_last_error() !== JSON_ERROR_NONE) {
			syslog(LOG_INFO, 'A JSON encoding failure has occurred. Message: ' . json_last_error_msg());
			return false;
		}
		$file = fopen($outputLocation, 'w+');
		if ($file === false) {
			syslog(LOG_INFO, 'Unable to open file: ' . $outputLocation . ' for writing.');
			return false;
		}
		if (fwrite($file, $encoded, strlen($encoded)) === false) {
			syslog(LOG_INFO, 'Writing to file: ' . $outputLocation . ' failed.');
			return false;
		}
		fclose($file);
		return true;
	}
}
