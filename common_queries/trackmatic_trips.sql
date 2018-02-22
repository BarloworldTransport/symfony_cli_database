SELECT `udo_cargo`.`ID` AS `Cargo ID`, `udo_cargo`.`tripNumber` AS `Trip Number`, `udo_customer`.`tradingName` AS `Customer`, 
CONCAT(`udo_driver`.`nickname`, ' [', `udo_driver`.`staffNumber`, ']') AS `Driver`, `udo_truck`.`fleetnum` AS `Truck`,
`udo_fleet`.`name` AS `Primary Fleet`, FROM_UNIXTIME(UNIX_TIMESTAMP(`udo_tripleg`.`loadingArrivalETA`)+7200) AS `Loading Arrival ETA`, 
FROM_UNIXTIME(UNIX_TIMESTAMP(`udo_tripleg`.`loadingArrivalTime`)+7200) AS `LoadingArrival Time`, 
FROM_UNIXTIME(UNIX_TIMESTAMP(`udo_tripleg`.`loadingStarted`)+7200) AS `Loading Started`, 
FROM_UNIXTIME(UNIX_TIMESTAMP(`udo_tripleg`.`loadingFinished`)+7200) AS `Loading Finished`, 
FROM_UNIXTIME(UNIX_TIMESTAMP(`udo_tripleg`.`timeLeft`)+7200) AS `Time Left`, 
FROM_UNIXTIME(UNIX_TIMESTAMP(`udo_tripleg`.`offloadingArrivalETA`)+7200) AS `Loading Arrival ETA`, 
FROM_UNIXTIME(UNIX_TIMESTAMP(`udo_tripleg`.`offloadingArrivalTime`)+7200) AS `Offloading Arrival Time`, 
FROM_UNIXTIME(UNIX_TIMESTAMP(`udo_tripleg`.`offloadingStarted`)+7200) AS `Offloading Started`, 
FROM_UNIXTIME(UNIX_TIMESTAMP(`udo_tripleg`.`offloadingCompleted`)+7200) AS `Offloading Completed`,
`fpp`.`name` AS `Loading Town`, `fpl`.`name` AS `Loading Point`,`tpp`.`name` AS `Offloading Town`, `tpl`.`name` AS `Offloading Point`,
`udo_tripleg`.`kmsBegin` AS `Kms Begin`,`udo_tripleg`.`kmsEnd` AS `Kms End`,`udo_odo`.`odo` AS `Depot Odo`, 
`udo_cargo`.`tonsActual` AS `Tons Actual`, FROM_UNIXTIME(UNIX_TIMESTAMP(`udo_tripleg`.`time_created`)+7200) AS `Time Created`,
IF(!ISNULL(`cp`.`first_name`), CONCAT(`cp`.`first_name`, ' ', `cp`.`last_name`), `cp`.`email`) AS `Created By`,
FROM_UNIXTIME(UNIX_TIMESTAMP(`udo_tripleg`.`time_last_modified`)+7200) AS `Last Update Time`,
IF(!ISNULL(`lmp`.`first_name`), CONCAT(`lmp`.`first_name`, ' ', `lmp`.`last_name`), `lmp`.`email`) AS `Last Updated By`,
FROM_UNIXTIME(UNIX_TIMESTAMP(`udo_trackingload`.`requestSent`)+7200) AS `Trackmatic Request Sent`,
FROM_UNIXTIME(UNIX_TIMESTAMP(`udo_trackingload`.`activated`)+7200) AS `Driver Activated On`
FROM `udo_cargo`
INNER JOIN `udo_trackingload` ON `udo_cargo`.`trip_id`=`udo_trackingload`.`trip_id`
LEFT JOIN `udo_triplegcargo` ON `udo_cargo`.`ID`=`udo_triplegcargo`.`cargo_id`
LEFT JOIN `udo_tripleg` ON `udo_tripleg`.`ID`=`udo_triplegcargo`.`tripleg_id`
LEFT JOIN `udo_odo` ON (
	`udo_odo`.`objectregistry_id`=(SELECT `ID` FROM `objectregistry` WHERE `handle`='udo_Cargo') AND
	`udo_cargo`.`ID`=`udo_odo`.`objectInstanceId`
	)
LEFT JOIN `udo_truck` ON `udo_truck`.`ID`=`udo_tripleg`.`truck_id`
LEFT JOIN `udo_customer` ON `udo_customer`.`ID`=`udo_cargo`.`customer_id`
LEFT JOIN `udo_driver` ON `udo_driver`.`ID`=`udo_tripleg`.`driver_id`
LEFT JOIN `udo_fleet` ON `udo_fleet`.`ID`=`udo_truck`.`primaryFleet_id`
LEFT JOIN `udo_location` AS `fpl` ON `fpl`.`ID`=`udo_tripleg`.`locationFromPoint_id`
LEFT JOIN `udo_location` AS `fpp` ON `fpp`.`ID`=`fpl`.`parent_id`
LEFT JOIN `udo_location` AS `tpl` ON `tpl`.`ID`=`udo_tripleg`.`locationToPoint_id`
LEFT JOIN `udo_location` AS `tpp` ON `tpp`.`ID`=`tpl`.`parent_id`
LEFT JOIN `permissionuser` AS `cb` ON `cb`.`id`=`udo_tripleg`.`created_by`
LEFT JOIN `person` AS `cp` ON `cp`.`ID`=`cb`.`person_id`
LEFT JOIN `permissionuser` AS `lmb` ON `lmb`.`id`=`udo_tripleg`.`last_modified_by`
LEFT JOIN `person` AS `lmp` ON `lmp`.`ID`=`lmb`.`person_id`
WHERE IF(!ISNULL(`udo_tripleg`.`loadingArrivalTime`),`udo_tripleg`.`loadingArrivalTime`,`udo_tripleg`.`loadingArrivalETA`)>='2018-01-01 00:00:00'
