--
local linux = "i686-berlinunited-linux-gnu"
local version = "4.9.3" 

-- intel atom
local cpu_flags = "-m32 -march=atom -mmmx -msse -msse2 -msse3 -mssse3"

-- handy definitions for some pathes
local crossDir = path.getabsolute(".") --NAO_CROSSCOMPILE .. "/" .. linux
local crossSystemDir = crossDir .. "/" .. linux

local gcc = premake.tools.gcc

if(_OPTIONS["platform"] == "Nao") then
  
  if _OPTIONS["clang"] ~= nil then
    print("INFO: Crosscompile with CLANG")
    toolset "clang"
    
    -- speciffic options for clang
    buildoptions {
      "-target i686-pc-linux-gnu"
    }
    linkoptions {
      "-target i686-pc-linux-gnu"--,
      --"-fuse-ld=" .. COMPILER_PATH_NAO .. "/bin/i686-berlinunited-linux-gnu-ld.exe"
    }
  else
    print("INFO: Crosscompile with GCC " .. version)
    
    -- reset compiler path to the cross compiler
    gcc.tools.cc     = crossDir .. "/bin/" .. linux .. "-gcc"
    gcc.tools.cxx    = crossDir .. "/bin/" .. linux .. "-g++"
    gcc.tools.ar     = crossDir .. "/bin/" .. linux .. "-ar"
    
    print("INFO: GCC path was changed for cross compiling to")
    print("> " .. crossDir)
  end
  
  buildoptions {
    "-MMD", -- its standard anyway
    cpu_flags,
    "--sysroot=" .. crossSystemDir .. "/sysroot/"
  }
  sysincludedirs {
    crossSystemDir .. "/sysroot/usr/include/",
    crossSystemDir .. "/include/c++/" .. version .. "/",
    crossSystemDir .. "/include/c++/" .. version .. "/" .. linux
  }
  linkoptions {
      --"-v",
      "--sysroot=" .. crossSystemDir .. "/sysroot/", 
      "-Wl,-rpath=/home/nao/lib"
  }
  syslibdirs {
    "\"" .. crossDir .. "/lib/gcc/" .. linux .. "/" .. version .. "/" .. "\"",
    crossSystemDir .. "/sysroot/lib/",
    crossSystemDir .. "/sysroot/usr/lib/"
  }
end

-- this seems to be necessary in order to have the compiler paths set in the generated Makefile
function gcc.gettoolname(cfg, tool)
  return gcc.tools[tool]
end

newoption {
   trigger     = "clang",
   description = "set the compiler to be clang"
}


