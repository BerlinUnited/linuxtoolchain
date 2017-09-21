#!/bin/bash

CURR=`pwd`
NAO_CTC=$CURR/toolchain_nao/
EXTERN_PATH_NATIVE=$CURR/toolchain_native/extern/

echo "-----------------------------------"
echo "- Generate projectconfig.user.lua -"
echo "-----------------------------------"


cat >projectconfig.user.lua <<EOL
-- special pathes which can be configured manualy.
-- If a path is set to 'nil' the default value is used.
-- for default values check projectconfig.lua

-- default: "../../Framework"
FRAMEWORK_PATH = nil

-- for native platform
-- default: "../../Extern"
EXTERN_PATH_NATIVE = "${EXTERN_PATH_NATIVE}"
-- webots instalation if available
-- default: os.getenv("WEBOTS_HOME")
WEBOTS_HOME = nil

-- path to the crosscompiler and libs
-- default: os.getenv("NAO_CTC")
NAO_CTC = "${NAO_CTC}"
-- or set both explicitely
-- default: NAO_CTC .. "/compiler"
COMPILER_PATH_NAO = nil
-- default: NAO_CTC .. "/extern"
EXTERN_PATH_NAO = nil


-- naoqi toolchain needed to compile the NaoSMAL
-- default: os.getenv("AL_DIR")
AL_DIR = nil

-- example: add additional dirs for both platforms
--if PLATFORM == "Nao" then
--  PATH:includedirs {"my/nao/includes/path"}
--  PATH:libdirs {"my/nao/libs/path"}
--else
--  PATH:includedirs {"my/native/includes/path"}
--  PATH:libdirs {"my/native/libs/path"}
--end
EOL


if [ -z "$DEFAULT" ]; then DEFAULT="n" ; fi
DEFSTRING="[Y/n]"
if [ "$DEFAULT" = "n" ]; then 
  DEFSTRING="[y/N]"
fi

# prevent multiple env_var definitions
if [[ -z "${NAO_CTC}" || -z "${EXTERN_PATH_NATIVE}" ]]; then

	echo -n "Do you want append NaoTH environment variables to ~/.bashrc? $DEFSTRING : "
	read ANSWER

	# set default answer
	if [ -z "$ANSWER" ]; then 
	  ANSWER=$DEFAULT
	fi

	if [ "$ANSWER" = "y" -o "$ANSWER" = "Y" ]
	then
	  echo "-----------------------"
	  echo "- extending ~/.bashrc -"
	  echo "------------------------"

	  echo "export PATH=\${PATH}:$CURR/toolchain_native/extern/bin:$CURR/toolchain_native/extern/lib # NAOTH" >> ~/.bashrc
	  echo "export NAO_CTC=$CURR/toolchain_nao/ # NAOTH" >> ~/.bashrc
	  echo "export EXTERN_PATH_NATIVE=$CURR/toolchain_native/extern/ # NAOTH" >> ~/.bashrc
	fi
else
  echo "NaoTH environment variables already defined."
fi

echo "-----------------------------------"
echo "- compiling external dependencies -"
echo "-----------------------------------"

cd toolchain_native/extern/
# make executeable
chmod u+x install_linux.sh
./install_linux.sh
