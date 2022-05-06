## https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html
SETUP_NVCC()
{ 
  echo "wget..."
  wget https://developer.download.nvidia.com/compute/cuda/redist/cuda_nvcc/linux-x86_64/cuda_nvcc-linux-x86_64-${RELEASE}-archive.tar.xz
  
  echo "tar..."
  rm -rf cuda_nvcc-linux-x86_64-${RELEASE}-archive
  tar -xf cuda_nvcc-linux-x86_64-${RELEASE}-archive.tar.xz 
}


SETUP_CUDART()
{ 
  echo "wget..."
  wget https://developer.download.nvidia.com/compute/cuda/redist/cuda_cudart/linux-x86_64/cuda_cudart-linux-x86_64-${RELEASE}-archive.tar.xz
  
  echo "tar..."
  rm -rf cuda_cudart-linux-x86_64-${RELEASE}-archive
  tar -xf cuda_cudart-linux-x86_64-${RELEASE}-archive.tar.xz
}


INIT()
{
  ## 1. SETUP 
  g++ --version   ## g++ (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0
  cmake --version ## cmake version 3.16.3

  NVCC_PATH=${PWD}/cuda_nvcc-linux-x86_64-${RELEASE}-archive
  CUDART_PATH=${PWD}/cuda_cudart-linux-x86_64-${RELEASE}-archive

  NVCC=$NVCC_PATH/bin/nvcc
  $NVCC --version

  rm -rf BUILD
  mkdir BUILD 
  cd BUILD 

  ## 2. COMPILATION
  ## 2.A. SIMPLEST  
  echo "SIMPLEST..."
  $NVCC -o smallest.x ../smallest.cu -I$CUDART_PATH/include -L$CUDART_PATH/lib
  ./smallest.x 
  rm smallest.x  

  ## 2.B. EASIEST  
  echo "EASIEST..."
  export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:$CUDART_PATH/include 
  export LIBRARY_PATH=$LIBRARY_PATH:$CUDART_PATH/lib 
  export CUDACXX=$NVCC 

  $CUDACXX  -o smallest.x ../smallest.cu  
  ./smallest.x 
  rm smallest.x
    
  ## 2.C. FANCIEST (https://www.collinsdictionary.com/dictionary/english/fanciest)
  echo "FANCIEST..."
  rm -rf CMakeCache.txt CMakeFiles  
  cmake ..
  make
  ctest
}


RELEASE=11.5.50 
SETUP_NVCC
SETUP_CUDART
INIT
