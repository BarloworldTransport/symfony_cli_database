<?php
namespace Unit\Output;
require_once __DIR__ . '/../../../src/output/json.php';
use \Output\json as json;

class jsonTest extends \PHPUnit_Framework_TestCase
{
	/**
	* @test
	*/
	public function validJsonReturnsTrue()
	{
		$json  = new json();
		$this->assertTrue($json->output($this->getGoodArray(), '/tmp/test.json'));

	}

	/**
	* @test
	*/
	public function invalidJsonReturnsFalse()
	{

	}

	/**
	* @test
	*/
	public function invalidFileWithSuppressionReturnsFalse()
	{
		$json  = new json();
		$this->assertFalse(@$json->output($this->getGoodArray(), '/root/test.json'));
	}

	private function getGoodArray(): array
	{
		return (array)[
			'test' => 'data',
			'more' => (array) [
				'one',
				2,
				3,
				'four'
			]
		];
	}
}