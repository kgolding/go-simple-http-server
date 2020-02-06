# go-simple-http-server

Super simple golang HTTP server with example systemd service file and buildroot package.

## Buildroot

Copy the files buildroot/* using the same directory structure into your buildroot directory.

Add the following line to the buildroot/package/Config.in file typically under the 'menu "Miscellaneous"' line.

`source "package/go-simple-http-server/Config.in"`

Run `make menuconfig` and enable your new 'go-simple-http-server' under Packages -> Miscellaneous.

## Usage
```
Usage of go-simple-http-server:
  -port int
        http port (default 80)
  -www string
        directory with files to be served (default "www")
```