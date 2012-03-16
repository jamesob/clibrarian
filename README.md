# CLIbrarian

Keep track of the shell commands you execute most. Inspired by [a Matt Might
article](http://matt.might.net/articles/console-hacks-exploiting-frequency/).
An excuse for me to play with CoffeeScript.

## Install

0. Have `npm` installed.
1. `git clone git@github.com:jamesob/clibrarian.git && cd clibrarian`
2. `npm install -d`
3. `coffee server.coffee`
4. Use (with the help of your fav HTTP client):

```sh
broderick ~ $ http POST http://localhost:3000/command command='make'
HTTP/1.1 200 OK
X-Powered-By: Express
Content-Type: application/json; charset=utf-8
Content-Length: 30
Connection: keep-alive

{
    "command": "make", 
    "numSeen": 1
}

broderick ~ $ http POST http://localhost:3000/command command='make'
HTTP/1.1 200 OK
X-Powered-By: Express
Content-Type: application/json; charset=utf-8
Content-Length: 30
Connection: keep-alive

{
    "command": "make", 
    "numSeen": 2
}

broderick ~ $ http POST http://localhost:3000/command command='ls -la'
HTTP/1.1 200 OK
X-Powered-By: Express
Content-Type: application/json; charset=utf-8
Content-Length: 32
Connection: keep-alive

{
    "command": "ls -la", 
    "numSeen": 1
}
```
