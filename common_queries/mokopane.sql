SELECT * 
FROM `mobilizesystem`.`login_history` 
WHERE `name` IN ('jmatjiu@bwtrans.co.za','ghlabe@bwtrans.co.za','mmokgokolo@bwtrans.co.za') AND `time`>=? AND `time`<=?
ORDER BY `name` ASC, `ID` ASC;
