sqlplus64 $bd_user/$bd_password@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=ora1.elka.pw.edu.pl)(Port=1521))(CONNECT_DATA=(SID=iais)))
select * from orders;
