<?php
namespace Database;
include dirname(realpath(__FILE__)) . '/../../vendor/autoload.php';

class select
{
	protected $pdo;

	public function doSelect($statement, $bindValues = array())
	{
		if (strtolower(substr($statement, 0, 6)) !== 'select') {
			syslog(LOG_INFO, 'Statement passed to select::doSelect not a SELECT statement.');
			return false;
		}
		if ($this->connectToMysql() === false) {
			syslog(LOG_WARNING, 'Could not successfully connect to a MySQL instance.');
			return false;
		}
		if ($bindValues) {
			try {
				$sth = $this->pdo->prepare($statement);
				$sth->execute($bindValues);
				return $sth->fetchAll(\PDO::FETCH_ASSOC);
			} catch (\PDOException $e) {
				syslog(LOG_WARNING, 'Could not successfully query against PDO. Error: ' . $e->getMessage());
				return false;
			}
		} else {
			try {
				$result = $this->pdo->query($statement);
				return $result->fetchAll(\PDO::FETCH_ASSOC);
			} catch (\PDOException $e) {
				syslog(LOG_WARNING, 'Could not successfully query against PDO. Error: ' . $e->getMessage());
				return false;
			}
		}
	}

	protected function connectToMysql(): bool
	{
		try {
			$reader = new \Zend\Config\Reader\Ini();
			$commonConfig = $reader->fromFile(__DIR__ . '/../../config/cli.ini');
			try {
				$dsn = 'mysql:host=' . $commonConfig['database']['host'] . ';dbname=' . $commonConfig['database']['schema'];
				$username = $commonConfig['database']['user'];
				$password = $commonConfig['database']['password'];
				$options = (array)[
					\PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES utf8',
					\PDO::ATTR_EMULATE_PREPARES => false,
					\PDO::ATTR_ERRMODE => \PDO::ERRMODE_EXCEPTION
				];
				$this->pdo = new \PDO($dsn, $username, $password, $options);
				return true;
			} catch (\PDOException $e) {
				syslog(LOG_WARNING, 'Could not instantiate PDO. Error: ' . $e->getMessage());
				return false;
			}
		} catch (\Exception $e) {
			syslog(LOG_WARNING, 'Could not instantiate Zend Config Reader. Error: ' . $e->getMessage());
			return false;
		}
	}
}