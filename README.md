# simpleEmailServer
This repository is part of a university subject exam, the project consist in a simple email server using sockets.

# Dependecies
	- Ruby: 2.7.2
		- minitest
	or
	- docker

# Running 
	if you have ruby installed use:
	ruby entrypoint.rb <host> <port> <dataset_clients_path>

	ex.

	```
	ruby entrypoint.rb localhost 7777 /tmp/clients.txt		
	```
	
	in case of you dont have ruby installed, but use docker container builder and
	runtime, use server_up.sh to run it.

	```
	server_up.sh localhost 7777 /tmp/clients.txt
	```
