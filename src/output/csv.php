<?php
namespace Output;
require_once dirname(realpath(__FILE__)) . DIRECTORY_SEPARATOR . 'output.php';

class csv implements output
{
	public function output(array $data, string $outputLocation = '/tmp/data.csv')
	{

	}
}