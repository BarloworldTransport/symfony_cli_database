<?php
namespace Output;

interface output
{
	public function output(array $data, string $outputLocation);
}