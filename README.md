## Nikto Web Vulnerability Scanner
[Nikto](https://github.com/sullo/nikto) from Sullo is a web server assessment tool. It is designed to find various default and insecure files, configurations and programs on any type of web server.

Call it without arguments to display the full help:

`docker run --rm osodevops/nikto:lates`

Basic usage
`docker run --rm osodevops/nikto:lates -h http://www.example.com`

To save the report in a specific format, mount /tmp as a volume:

`docker run --rm -v $(pwd):/tmp osodevops/nikto:lates -h http://www.example.com -o /tmp/out.json`

