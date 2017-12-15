SELECT `c`.`ID` AS `City ID`, `cd`.`name` AS `City`, `p`.`name` AS `Province or Country`, `cd`.`active` AS `Active`
FROM `udo_city` AS `c`
LEFT JOIN `udo_location` AS `cd` ON `cd`.`ID`=`c`.`_udo_Location_id`
LEFT JOIN `udo_location` AS `p` ON `p`.`ID`=`cd`.`parent_id`
WHERE 1=1;
