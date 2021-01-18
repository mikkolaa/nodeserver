/* Ladataan Express-modulit */
/* npm install express 
   npm install mssql */
var express = require('express');
var app = express();

/* Requestin käsittely */
app.get('/', function (req, res) {
  /* Driverin installointi: npm install mssql	*/
  /* Katso, että palvelimella on SQL Server Browser päällä */
    var sql = require("mssql");

  /* Connection-konfiguraatio */
    var config = {
        user: 'sa',
        password: 'xxxxxxx',
        server: 'DESKTOP-NI8TNFP\\SQLEXPRESS', 
        database: 'Northwind',
	port: 1433 						
    };
    
    sql.connect(config, function (err) {    
	    if (err) 
	       console.log(err);

	    var request = new sql.Request();           
		
	    request.query('select * from Customers', function (err, recordset) {            
            if (err) 
	        console.log(err)
            /* Data streamiin joka näkyy clintille json:na */
            res.send(recordset);            
        });
    });
});

var server = app.listen(5000, function () {
    console.log('Server is running in URL: http://localhost:5000');
});
