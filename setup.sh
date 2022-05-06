apt-get --yes -qq update 
DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get -y install tzdata
apt-get --yes -qq update 

apt-get --yes -qq install wget xz-utils
apt-get --yes -qq install build-essential  
apt-get --yes -qq install gcc g++  
apt-get --yes -qq install cmake 
apt-get --yes -qq install cmake-curses-gui ## ccmake 
apt-get --yes -qq clean
rm -rf /var/lib/apt/lists/*
