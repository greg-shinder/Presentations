docker pull mcr.microsoft.com/mssql/server:latest

#remove containers from previous demo
docker stop sql1
docker stop sql2
docker rm sql1
docker rm sql2
docker volume rm sqlvolume1 
docker volume rm sqlvolume2



docker volume create sqlvolume1
docker volume create sqlvolume2


docker create -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=Pa55w.rd" -e "MSSQL_AGENT_ENABLED=True" --name sql2 -v sqlvolume2:/var/opt/mssql -p1402:1433 -i mcr.microsoft.com/mssql/server:latest
docker create -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=Pa55w.rd" -e "MSSQL_AGENT_ENABLED=True" --name sql1 -v sqlvolume1:/var/opt/mssql -p1401:1433 -i mcr.microsoft.com/mssql/server:latest
docker start sql1
docker start sql2


#Setup aliases, requires elevated prompt
New-DbaClientAlias -ServerName "localhost,1401" -Alias sql1  
New-DbaClientAlias -ServerName "localhost,1402" -Alias sql2

Get-DbaClientAlias