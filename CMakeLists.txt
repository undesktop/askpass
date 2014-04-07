### BOILERPLATE ###
cmake_minimum_required ( VERSION 2.8 )
list ( APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake )
set ( CMAKE_INCLUDE_CURRENT_DIR ON )
set ( CMAKE_COLOR_MAKEFILE ON )

string ( COMPARE EQUAL "${CMAKE_SOURCE_DIR}" "${CMAKE_BINARY_DIR}" insource )
if ( insource )
	message ( FATAL_ERROR "All undesktop projects require an out-of-source build." )
endif ( insource )

### PROJECT INFO ###
project ( Undesktop-AskPass C )
set ( VERSION "0.1.0" )
set ( COPYRIGHT "Copyright 2014 Undesktop.org and contributors" )
set ( DESCRIPTION "Undesktop project AskPass utility" )
set ( WEBSITE "http://undesktop.org/askpass/")


### PKGCONFIG ###
find_package ( PkgConfig REQUIRED )
pkg_check_modules ( DEPS
	REQUIRED glib-2.0
	REQUIRED gmodule-2.0
	REQUIRED gtk+-3.0>=3.10
	REQUIRED cairo
)
include_directories ( ${DEPS_INCLUDE_DIRS} )
link_libraries ( ${DEPS_LIBRARIES} )
link_directories ( ${DEPS_LIBRARY_DIRS} )
add_definitions ( ${DEPS_CFLAGS} )

### GRESOURCE FILES ###
include ( GResource )
set ( GRESOURCES ${CMAKE_CURRENT_SOURCE_DIR}/resources/org.undesktop.askpass.gresource.xml )
glib_compile_resources ( RESOURCE_FILE SOURCE resources/org.undesktop.askpass.gresource.xml )


### VALA FILES ###
find_package ( Vala REQUIRED )
include ( ValaVersion )
ensure_vala_version ( "0.20" MINIMUM )


### Compile ###
include ( ValaPrecompile )
vala_precompile (
VALA_C undesktop-ssh-askpass
	src/SafePassword.vala
	src/AskPass.vala
PACKAGES
	gtk+-3.0
	glib-2.0
	gmodule-2.0
	cairo
	posix
OPTIONS
	--enable-experimental-non-null
	--target-glib=2.38
	--gresources=${GRESOURCES}
)

# Source files definition
set ( SRC_FILES ${RESOURCE_FILE} ${VALA_C} )

add_executable ( undesktop-ssh-askpass ${SRC_FILES} )

target_link_libraries ( undesktop-ssh-askpass ${DEPS_LIBRARIES} m )

# Installation
install ( PROGRAMS ${CMAKE_CURRENT_BINARY_DIR}/undesktop-ssh-askpass
          DESTINATION lib/ssh/ )
execute_process ( COMMAND ${CMAKE_COMMAND} -E create_symlink undesktop-ssh-askpass
                                           ${CMAKE_CURRENT_BINARY_DIR}/ssh-askpass )
install ( PROGRAMS ${CMAKE_CURRENT_BINARY_DIR}/ssh-askpass
          DESTINATION lib/ssh/ )
