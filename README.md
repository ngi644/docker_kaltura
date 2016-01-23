# A Dockerfile for Kaltura


## Build Image

$ sudo docker build -t kaltura .


## Start Container

$ docker run --name kaltura_sv -d -p 10022:22 -p 80:80 -p 5080:5080 kaltura


## Access to container using SSH

$ ssh -p 10022 root@localhost


## Reference

- https://github.com/kaltura/platform-install-packages/tree/Kajam-11.7.0/vagrant
