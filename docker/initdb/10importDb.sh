#!/bin/bash
dbFilesFolder="dbfiles"
dataDividers="cora diva"

importForDataDivider () {
	for SQL in "$1"/* ;	do
		echo "Run SQL file: $SQL"
		psql -v ON_ERROR_STOP=1 -U $POSTGRES_USER $POSTGRES_PASSWORD < $SQL > $SQL.log
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