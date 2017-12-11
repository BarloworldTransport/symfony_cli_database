<?php
namespace database;

class select
{
	protected function instantiateAtlas(): Atlas
	{
		try {
			$reader = new \Zend\Config\Reader\Ini();
			$commonConfig = $reader->fromFile(__DIR__ . '/../../../config/cli.ini');
			try {
				$atlasContainer = new AtlasContainer(
					'mysql:host=' . $commonConfig['database']['host'] . ';dbname=' . $commonConfig['database']['schema'],
					$commonConfig['database']['user'],
					$commonConfig['database']['password']
				);
				$atlasContainer->setMappers([]);
				$atlas = $atlasContainer->getAtlas();
				return $atlas;
			} catch (\Exception $e) {
				syslog(LOG_WARNING, 'Could not instantiate Atlas Container. Error: ' . $e->getMessage());
			}
		} catch (\Exception $e) {
			syslog(LOG_WARNING, 'Could not instantiate Zend Config Reader. Error: ' . $e->getMessage());
		}
	}
}