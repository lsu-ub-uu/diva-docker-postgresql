#!/bin/bash
dbFilesFolder="dbfiles"
dataDividers="cora jsClient diva divaPreview divaPre divaProduction divaTestSystem divaClient"
PGPASSWORD=$POSTGRES_PASSWORD

importForDataDivider () {
	for SQL in "$1"/* ;	do
		echo "Run SQL file: $SQL"
		psql -v ON_ERROR_STOP=1 -U $POSTGRES_USER $POSTGRES_DB < $SQL > $SQL.log
	done
}

start(){
	for dataDivider in $dataDividers ; do
		echo ""
		echo "Importing dataDivider: "$dataDivider
		importForDataDivider $dbFilesFolder"/"$dataDivider
	done
}

start