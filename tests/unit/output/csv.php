<?php
namespace Unit\Output;
require_once __DIR__ . '/../../../src/output/csv.php';
use \Output\csv as csv;

class csvTest extends \PHPUnit_Framework_TestCase
{
	/**
	* @test
	*/
	public function validCsvReturnsTrue()
	{
		$csv  = new csv();
		$this->assertTrue($csv->output($this->getGoodArray(), '/tmp/test.csv'));

	}

	/**
	* @test
	*/
	public function invalidFileWithSuppressionReturnsFalse()
	{
		$csv  = new csv();
		$this->assertFalse(@$csv->output($this->getGoodArray(), '/root/test.csv'));
	}

	private function getGoodArray(): array
	{
		return (array)[
			[
				'test1' => 'data01',
				'test2' => 'data02',
				'test3' => 'data03',
				'test4' => 'data04',
				'test5' => 'data05',
				'test6' => 'data06',
				'test7' => 'data07',
			],
			[
				'test1' => 'data08',
				'test2' => 'data09',
				'test3' => 'data10',
				'test4' => 'data11',
				'test5' => 'data12',
				'test6' => 'data13',
				'test7' => 'data14',
			],
			[
				'test1' => 'data15',
				'test2' => 'data16',
				'test3' => 'data17',
				'test4' => 'data18',
				'test5' => 'data19',
				'test6' => 'data20',
				'test7' => 'data21',
			],
			[
				'test1' => 'data22',
				'test2' => 'data23',
				'test3' => 'data24',
				'test4' => 'data25',
				'test5' => 'data26',
				'test6' => 'data27',
				'test7' => 'data28',
			]
		];
	}
}