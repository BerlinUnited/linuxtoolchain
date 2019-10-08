#!/bin/bash
echo "-----------------------------------"
echo "-   Set environment variables     -"
echo "-----------------------------------"


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

-- needed for compiling of LogSimulatorJNI, paths must be adjusted
-- this might not be necessary in some linux distros
--[[
if _OPTIONS["JNI"] ~= nil then
  includedirs {
    "C:/Program Files (x86)/Java/jdk1.8.0_131/include",
    "C:/Program Files (x86)/Java/jdk1.8.0_131/include/win32"
  }
end
]]
EOL

echo "-----------------------------------"
echo "- compiling external dependencies -"
echo "-----------------------------------"

cd toolchain_native/extern/
# make executeable
chmod u+x install_linux.sh
./install_linux.sh
