SELECT `tl`.`ID` AS `TripLeg ID`, `tr`.`fleetnum` AS `Fleet Number`, `tr`.`FM`, `tr`.`cellnum` AS `Tracking #`, `cu`.`tradingName` AS `Customer`, 
`ca`.`tripNumber` AS `Trip Number`, `fpp`.`name` AS `Loading Town`, `tpp`.`name` AS `OffLoading Town`, 
FROM_UNIXTIME(UNIX_TIMESTAMP(`tl`.`loadingArrivalETA`)+120) AS `Loading Arrival ETA`, 
FROM_UNIXTIME(UNIX_TIMESTAMP(`tl`.`loadingArrivalTime`)+120) AS `LoadingArrival Time`, 
FROM_UNIXTIME(UNIX_TIMESTAMP(`tl`.`loadingStarted`)+120) AS `Loading Started`, 
FROM_UNIXTIME(UNIX_TIMESTAMP(`tl`.`loadingFinished`)+120) AS `Loading Finished`, 
FROM_UNIXTIME(UNIX_TIMESTAMP(`tl`.`timeLeft`)+120) AS `Time Left`, 
FROM_UNIXTIME(UNIX_TIMESTAMP(`tl`.`offloadingArrivalETA`)+120) AS `Loading Arrival ETA`, 
FROM_UNIXTIME(UNIX_TIMESTAMP(`tl`.`offloadingArrivalTime`)+120) AS `Offloading Arrival Time`, 
FROM_UNIXTIME(UNIX_TIMESTAMP(`tl`.`offloadingStarted`)+120) AS `Offloading Started`, 
FROM_UNIXTIME(UNIX_TIMESTAMP(`tl`.`offloadingCompleted`)+120) AS `Offloading Completed`,
`tl`.`kmsBegin` AS `KMs Begin`, `tl`.`kmsEnd` AS `KMs End`, `ca`.`tonsActual` AS `Pay Load`
FROM `udo_tripleg` AS `tl`
LEFT JOIN `udo_truck` AS `tr` ON `tr`.`ID`=`tl`.`truck_id`
LEFT JOIN `udo_triplegcargo` AS `tlc` ON `tl`.`ID`=`tlc`.`tripLeg_id`
LEFT JOIN `udo_cargo` AS `ca` ON `ca`.`ID`=`tlc`.`cargo_id`
LEFT JOIN `udo_customer` AS `cu` ON `cu`.`ID`=`ca`.`customer_id`
LEFT JOIN `udo_location` AS `fpl` ON `fpl`.`ID`=`tl`.`locationFromPoint_id`
LEFT JOIN `udo_location` AS `fpp` ON `fpp`.`ID`=`fpl`.`parent_id`
LEFT JOIN `udo_location` AS `tpl` ON `tpl`.`ID`=`tl`.`locationToPoint_id`
LEFT JOIN `udo_location` AS `tpp` ON `tpp`.`ID`=`tpl`.`parent_id`
WHERE `cu`.`tradingName` LIKE '%Anglo%' AND IF (!ISNULL(`tl`.`loadingArrivalTime`), `tl`.`loadingArrivalTime`>='?', `tl`.`loadingArrivalETA`>='?')
ORDER BY `Loading Arrival ETA` DESC