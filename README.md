# docker-dogecoind
Docker Image for Dogecoin

### Quick Start
Create a dogecoind-data volume to persist the dogecoind blockchain data, should exit immediately. The dogecoind-data container will store the blockchain when the node container is recreated (software upgrade, reboot, etc):
```
docker volume create --name=dogecoind-data
```
Create a dogecoin.conf file and put your configurations
```
mkdir -p ~/.dogedocker
nano /home/$USER/.dogedocker/dogecoin.conf
```

Run the docker image
```
docker run -v dogecoind-data:/dogecoin --name=dogecoind-node -d \
      -p 22555:22555 \
      -p 22556:22556 \
      -v /home/$USER/.dogedocker/dogecoin.conf:/dogecoin/.dogecoin/dogecoin.conf \
      bitsler/docker-dogecoind:latest
```

Check Logs
```
docker logs -f dogecoind-node
```

Auto Installation
```
sudo bash -c "$(curl -L https://git.io/fxICW)"
```

Auto Update utility
```
sudo bash -c "$(curl -L https://git.io/fjrqV)"
```