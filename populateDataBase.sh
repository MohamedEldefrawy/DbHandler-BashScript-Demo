#! /bin/bash
############## Script parse text file separated by spaces and insert it into database
### Exit codes
###             0: Success
###             4: Missing parameter

DB_USER="root"
DB_PASSWD="Mohamed\$5265104@D"

OrderInsert=$(awk '{print "insert into Bills.Orders values(" $1 ",\"" $2 "\", \"" $3 "\");"}' ./Orders.txt)
OrderDetailsInsert=$(awk '{print "insert into Bills.OrderDetails values(" $1 "," $2 ", \"" $3 "\", "$4","$5");"}' ./OrderDetails.txt)

mysql --user=$DB_USER --password=$DB_PASSWD -e "$OrderInsert"
mysql --user=$DB_USER --password=$DB_PASSWD -e "$OrderDetailsInsert"

exit 0
