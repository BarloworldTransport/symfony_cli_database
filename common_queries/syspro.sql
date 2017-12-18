SELECT `c`.`ID`, `c`.`sysproSalesOrder` AS `SalesOrderNo`, `companyInvoiceNumber`, `tripNumber`, `additionalCharges`, `c`.`businessUnit_id`, `sysproOrderPlaced`, `sysproError`, `rt`.`name` AS `rateType` 
FROM `udo_cargo` AS `c` LEFT JOIN `udo_triplegcargo`  AS `tlc` ON `c`.`ID`=`tlc`.`cargo_id` 
INNER JOIN `udo_rates` as `r` ON (`r`.`ID`=`c`.`rate_id`) 
INNER JOIN `udo_ratetype` as `rt` ON (`rt`.`ID`=`r`.`ratetype_id`) 
WHERE `c`.`tripNumber` IN(::);
