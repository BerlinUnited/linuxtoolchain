#!/bin/bash

if [ -z "$DEFAULT" ]; then DEFAULT="n" ; fi
DEFSTRING="[Y/n]"
if [ "$DEFAULT" = "n" ]; then 
  DEFSTRING="[y/N]"
fi

PROFILE_NAOTH_TOOLCHAIN_STRING="export NAOTH_TOOLCHAIN_PATH=$(pwd)"
PROFILE_NAOTH_TOOLCHAIN_CURRENT=$(cat ~/.profile | grep "export NAOTH_TOOLCHAIN_PATH=")

# prevent multiple env_var definitions
if [[ -z "${NAOTH_TOOLCHAIN_PATH}" ]]; then

    NAOTH_TOOLCHAIN_PATH=`pwd`

	echo -n "Do you want append NaoTH environment variables to ~/.profile? $DEFSTRING : "
	read ANSWER

	# set default answer
	if [ -z "$ANSWER" ]; then 
	  ANSWER=$DEFAULT
	fi

	if [ "$ANSWER" = "y" -o "$ANSWER" = "Y" ]
	then
	  echo "------------------------"
	  echo "- extending ~/.profile -"
	  echo "------------------------"

	  # force new line
	  echo  >> ~/.profile
	  #
	  echo "# NAOTH Toolchain" >> ~/.profile
	  echo "$PROFILE_NAOTH_TOOLCHAIN_STRING" >> ~/.profile
	  echo "[[ -f $NAOTH_TOOLCHAIN_PATH/.naoth.profile ]] && . $NAOTH_TOOLCHAIN_PATH/.naoth.profile" >> ~/.profile
	fi
elif [[ "$PROFILE_NAOTH_TOOLCHAIN_STRING" != "$PROFILE_NAOTH_TOOLCHAIN_CURRENT" ]]; then

	echo -e -n "NaoTH toolchain path in the ~/.profile is different to this path!\nDo you want to replace it? $DEFSTRING : "
	read ANSWER

	# set default answer
	if [ -z "$ANSWER" ]; then 
	  ANSWER=$DEFAULT
	fi

	if [ "$ANSWER" = "y" -o "$ANSWER" = "Y" ]
	then
		# replace toolchain path and using | as sed delimiter
		sed -i "s|$PROFILE_NAOTH_TOOLCHAIN_CURRENT|$PROFILE_NAOTH_TOOLCHAIN_STRING|g" ~/.profile
	fi
else
  echo "NaoTH environment variables already defined."
fi

# load (new) profile
. ~/.profile

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

echo "-----------------------------------"
echo "- compiling external dependencies -"
echo "-----------------------------------"

cd toolchain_native/extern/
# make executeable
chmod u+x install_linux.sh
./install_linux.sh

echo "------------------------------------------------------"
echo "- restart is needed in order for the changes to work -"
echo "------------------------------------------------------"